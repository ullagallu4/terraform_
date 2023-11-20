data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "instane-AL3" {
  ami             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = var.ps1
  security_groups = var.sg_id

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo dnf update -y"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("~/ansible.pem")
  #     host        = self.public_ip
  #   }
  # }
}





  