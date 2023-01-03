# 1. Instalacja git, terraform ,aws_cli2
brew install git terraform awscli
# 2. Zalogowanie awscli do AWS
zaloguj się przez web do AWS,
kliknij na link https://us-east-1.console.aws.amazon.com/iamv2/home?region=ue-central-1#/security_credentials - wygeneruj "Access keys"

w iterm uruchom : aws configure - wprowadz pobrazne "Access keys" jako region wpisz "eu-central-1"

# 3. załoz nowy bucket - do przechowywania stanu terraform 
w iterm uruchom : aws s3 mb s3://moja-nawa-bucket-111 

# 4. pobierz repozytorium terraform 
git clone git@git.escolasoft.com:startup-academy/terraform-ecs-stage.git

# 5. wprowadz nazwe bucketu z punktu 3. do pliku main.tf w lini 9 zamiast escola-terraform-states-all

# 6. zbuduj srodowisko
w katalogu terraform uruchom : 

terraform init 

terraform apply
   