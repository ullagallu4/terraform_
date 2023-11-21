output "ssh_command" {
  value = "ssh -i \"ugl.pem\" ec2-user@${aws_instance.instane-AL3.public_dns}"
}