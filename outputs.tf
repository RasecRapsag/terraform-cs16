output "dns" {
	description = "Endereço público da instância"
	value = "${aws_instance.cs16.public_dns}"
}

output "ip" {
	description = "IP público da instância"
	value = aws_instance.cs16.public_ip
}
