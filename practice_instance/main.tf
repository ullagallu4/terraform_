data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "instane-ubuntu" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name = var.key_name
  subnet_id       = var.ps1
  security_groups = var.sg_id

  root_block_device {
    volume_size = 8 # GB
    volume_type = "gp3"
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo apt update -y"
     ] 
    
    connection {
      type        = "ssh"
      user        = "ubuntu" 
      private_key = file("~/ansible.pem")
      host        = self.public_ip
    }
  }
}





  