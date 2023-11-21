resource "aws_instance" "instane-AL3" {
  ami             = data.aws_ami.amzn2.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  user_data = file("${path.module}/myscript-go.sh")

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
    Name = "WebServer"
  }
}





  