resource "aws_instance" "instane-AL3" {
  # ami=data.aws_ami.amzn2.id
  # user_data = file("${path.module}/docker.sh")
  ami           = data.aws_ami.amzn3.id
  user_data     = file("${path.module}/docker.sh")
  instance_type = var.instance_type
  key_name      = var.key_name


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
  tags = {
    Name = "docker"
  }
}





  