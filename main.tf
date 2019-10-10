#
# Provider AWS
#
provider "aws" {
	shared_credentials_file = "/home/cgaspar/.aws/credentials"
	profile = "default"
	region = var.region
}

#
# Key Pair
#
resource "aws_key_pair" "cs16-key" {
	key_name = "cs16-key"
	public_key = "${file("~/.ssh/id_rsa.pub")}"
}

#
# Security Group
#
resource "aws_security_group" "allow-cs16" {
	name = "allow-cs16"

	# Entrada SSH
	ingress {
		from_port = var.ssh_port
		to_port = var.ssh_port
		protocol = "tcp"
		cidr_blocks = var.cidrs
	}
	# Entrada CS 1.6
	ingress {
		from_port = var.cs16_port
		to_port = var.cs16_port
		protocol = "udp"
		cidr_blocks = var.cidrs
	}
	# Saida
	egress {
		from_port = 0
		to_port = 0
		protocol = -1 # qualquer protocolo
		cidr_blocks = ["0.0.0.0/0"]
	}
}

#
# Instancia
#
resource "aws_instance" "cs16" {
	instance_type = var.instance_type
	ami = var.amis[var.region]

	key_name = "${aws_key_pair.cs16-key.key_name}"
	security_groups = ["${aws_security_group.allow-cs16.name}"]

	# Define Volume Root
	root_block_device {
		volume_size = 20
		volume_type = "gp2"
	}

	provisioner "local-exec" {
		command = "echo ${aws_instance.cs16.public_ip} > ip_address.txt"
	}

	tags = var.tags
}
