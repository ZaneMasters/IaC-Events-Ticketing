# Infraestructura como Código (IaC) - Ticketing API

Este proyecto contiene la definición de infraestructura de la plataforma reactiva de ticketing, completamente abstraída en **Terraform**.

## Arquitectura Cloud-Native (AWS)
La solución está enfocada en componentes "Serverless" y administrados bajo los principios de *Elasticidad y Alta Disponibilidad*.

1. **Networking (`modules/networking`)**: Crea una Virtual Private Cloud (VPC) con subredes públicas (para el ALB / IGW) y privadas (donde residen los contenedores de la aplicación) en dos Zonas de Disponibilidad distintas.
2. **Compute (`modules/compute`)**: Define la ejecución inmutable utilizando contenedores en **ECS Fargate**. Incluye el repositorio **ECR** para subir la imagen generada por Spring Boot, Grupos de Seguridad (SGs), el Application Load Balancer (ALB) y las políticas y roles (IAM) correctos bajo el principio de menor privilegio.
3. **Database (`modules/dynamodb`)**: Provisiona **DynamoDB** con el modo On-Demand (Pagos por Petición) para evitar sobrecargos por capacidad ociosa, asegurando latencia debajo de 10ms.
4. **Messaging (`modules/sqs`)**: Crea la cola asíncrona estándar de SQS encargada de gestionar los picos de pedidos (Orders).
5. **API Gateway (`modules/apigateway`)**: Actúa como un proxy de entrada expuesto que dirige tráfico al ALB interno, proporcionando la primera barrera de throttling si se requieren extensiones posteriores.

---

## 🛠️ Cómo Iniciar

### 1. Inicializar los Módulos
Sitúate en esta carpeta (`/iac`) que contiene el archivo `main.tf` y ejecuta:
```bash
terraform init
```

### 2. Validar o Formatear
```bash
terraform validate
terraform fmt -recursive
```

### 3. Plan de Ejecución
Para visualizar qué creará Terraform en tu cuenta AWS:
```bash
terraform plan
```

### 4. Desplegar
Confirma la creación de los componentes en tu cuenta. Presta especial atención al valor de la variable `environment` y al exporte (outputs) una vez termine.
```bash
terraform apply
```

---

## 🚀 Flujo de Despliegue de la Aplicación (El paso a paso a Producción)

Una vez que `terraform apply` finaliza:

1. **Observa el output `ecr_repository`**, allí deberás _pushear_ la imagen Docker de Spring Boot compilada.
2. **Inicia sesión de Docker en ECR:**
   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <tu_account_id>.dkr.ecr.us-east-1.amazonaws.com
   ```
3. **Sube la imagen etiquetada:**
   ```bash
   docker tag ticketing-app:latest <ecr_repository_url>:latest
   docker push <ecr_repository_url>:latest
   ```
4. Fargate comenzará a desplegar tu Task, pasará tu Health check en `/actuator/health` y el servicio completo se expondrá de manera segura en el `api_endpoint` entregado en los Terraform Outputs.
