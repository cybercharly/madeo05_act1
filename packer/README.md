# madeo05_act1 - Despliegue de Nginx y Nodejs mediante una imagen generada por Packer

## Actividad:

El codigo de packer y bash script aqui presente crea una AMI basada en Amazon Linux que a su vez es modificado en tiempo de creacion para realizar la siguientes actividades:
- actualizar OS
- Instalar NGINX
- Instalar una aplicacion dummy de NODEJS que publica un `Hola Mundo`
- Configurar el NGINX para que publique la aplicacion de NGINX
- Empaqueta la imagen y le pone la fecha para tener una imagen resultante con el siguiente formato `PackerBaseImage-DDMMAAAA`

## Como Usar

### Pre-requisitos
Antes de comenzar, asegurate de tener instaladas las siguientes herramientas

1. **Packer**: [Descargar e Instalar Packer](https://developer.hashicorp.com/packer/install)
2. **GIT**: [Descargar e Instalar GIT](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Instalaci%C3%B3n-de-Git)

Despues de tener las herramientas necesarias sigue los siguientes pasos para replicar la actividad:

* Clonar este repositorio localmente `git clone git@github.com:cybercharly/madeo05act1.git`
* Tener una cuenta de AWS
* Asegurate de tus credenciales de acceso programatico estan previamente configuradas con `aws configure`, [puedes seguir la documentacion oficial](https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-user.html)

El repositorio previamente clonado tiene la actividad de packer en el directorio `packer`, sigue las instrucciones como se muestran para a continuacion para ejecutar la creacion de la ami customizada:

```bash
## Initialize Packer configuration
packer init .

## Format and validate your Packer template
packer validate -var-file=vars-x86.pkrvars.hcl PackerBaseImage.pkr.hcl

## Build Packer image
packer build -var-file=vars-x86.pkrvars.hcl PackerBaseImage.pkr.hcl
```

## Comenzando
**Ejemplo del output que recibiremos por consola**

```packer
    madeo05-act1-packer.amazon-ebs.amazon_linux: Installation and configuration complete. The application is running on port 80.
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Stopping the source instance...
    madeo05-act1-packer.amazon-ebs.amazon_linux: Stopping instance
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Waiting for the instance to stop...
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Creating AMI PackerBaseImage--11262024 from instance i-0762aeec7f6781b90
    madeo05-act1-packer.amazon-ebs.amazon_linux: AMI: ami-086216a3ce2ed354c
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Waiting for AMI to become ready...
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Skipping Enable AMI deprecation...
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Terminating the source AWS instance...
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Cleaning up any extra volumes...
==> madeo05-act1-packer.amazon-ebs.amazon_linux: No volumes to clean up, skipping
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Deleting temporary security group...
==> madeo05-act1-packer.amazon-ebs.amazon_linux: Deleting temporary keypair...
Build 'madeo05-act1-packer.amazon-ebs.amazon_linux' finished after 7 minutes 38 seconds.
```


**Salidas tras la Ejecucion**
| Nombre | Descripcion |
|------|-------------|
| us-east-1 | AMI ID de la imagen recien creada |

### Notable
* Nada notable que mencionar ahora

## Contribuidores al Proyecto
| Nombre | Email |
|------|-------|
| Juan Carlos Perez Hernandez | jc.przhdz@gmail.com |

# Registro de Cambios
***
### Version 1.0.0
***Se Agregaron***
* Se agrego el codigo de packer principal
* Se agrego el codigo de packer para manejar variables
* Se agrego el bash script para hacer la post-configuracion
* Se agrego el README