# madeo05_act1 - Despliegue de Nginx y Nodejs mediante una imagen generada por Packer

## Actividad: 

El codigo terraform presente en este directorio nos ayuda a desplegar en AWS la AMI que recien creamos con Packer de forma automatizada y sin intervencion humada alguna


## Como Usar

### Pre-requisitos
Antes de comenzar, asegurate de tener instaladas las siguientes herramientas

1. **Terraform**: [Descargar e Instalar Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. **GIT**: [Descargar e Instalar GIT](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Instalaci%C3%B3n-de-Git)

Despues de tener las herramientas necesarias sigue los siguientes pasos para replicar la actividad:

* Clonar este repositorio localmente `git clone git@github.com:cybercharly/madeo05act1.git`
* Tener una cuenta de AWS
* Asegurate de tus credenciales de acceso programatico estan previamente configuradas con `aws configure`, [puedes seguir la documentacion oficial](https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-user.html)
* Actualiza `providers.tf` linea `3` con la informacion de tus credenciales de AWS
* Ejecuta los siguientes comandos

```bash
terraform init
terraform validate
terraform apply --auto-approve
```

## Comenzando
**Ejemplo**

```terraform
resource "aws_instance" "madeo05act1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = local.public1_subnet_id
  vpc_security_group_ids      = [aws_security_group.madeo05act1_sg.id]
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true

  }

  tags = {
    terraform = true
    materia = "madeo05act1"
  }
}
```

**Salidas tras la Ejecucion**
| Nombre | Descripcion |
|------|-------------|
| ec2_public_dns | DNS publico de la instancia de EC2 desplegada |
| ec2_public_ip | Direccion IP publica de la instancia de EC2 desplegada |

### Notable
* se creara una EC2 instance en `us-east-1` la cual tendra una IP publica y DNS publico con el cual podremos consultar la aplicacion dummy de nodejs que fue creada con packer

## Contribuidores al Proyecto
| Nombre | Email |
|------|-------|
| Juan Carlos Perez Hernandez | jc.przhdz@gmail.com |

# Registro de Cambios
***
### Version 1.0.0
***Se Agregaron***
* Se agrego el codigo terraform para crear la red
* Se agrego el codigo terraform para crear el security group
* Se agrego el README