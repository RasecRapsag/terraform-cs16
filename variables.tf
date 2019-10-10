variable "region" {
	description = "Regiao na AWS"
	type = string
	default = "sa-east-1"
}

variable "instance_type" {
	description = "Tipo de instância a ser utilizado"
	type        = string
	default     = "t2.micro"
}

variable "amis" {
	description = "Amis Ubuntu 18.04"
	type = map
	default = {
		"sa-east-1" = "ami-02a3447be1ec3a38f"
		"us-east-1" = "ami-0ff8a91507f77f867"
	}
}

variable "tags" {
	description = "Tags da instância"
	type = map

	default = {
		"Name"     = "Counter Strike 1.6"
		"Ambiente" = "Terraform"
	}
}

variable "ssh_port" {
	description = "Porta SSH"
	type        = string
	default     = 22
}

variable "cs16_port" {
	description = "Porta CS 1.6"
	type        = string
	default     = 27015
}

variable "cidrs" { 
	description = "Cidrs Liberados"
	type = list
}
