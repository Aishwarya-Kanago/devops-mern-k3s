output "ec2_public_ip" {
  value = aws_instance.k3s_server.public_ip
}

output "jenkins_url" {
  value = "http://${aws_instance.k3s_server.public_ip}:8080"
}

output "ssh_cmd" {
  value = "ssh -i <your-key.pem> ubuntu@${aws_instance.k3s_server.public_ip}"
}