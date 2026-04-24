Terraform Lab - Docker Web Infrastructure

Projekt demonstracyjny Infrastructure as Code (IaC) z wykorzystaniem Docker i Terraform.

Zadanie domowe: Migracja kompletnego środowiska

Cel

Celem projektu było stworzenie kompletnego środowiska aplikacji webowej w Docker
oraz odwzorowanie tej infrastruktury w Terraform zgodnie z dobrymi praktykami IaC.

Zakres projektu

Środowisko składa się z trzech głównych komponentów:
- aplikacja web (Flask)
- baza danych PostgreSQL
- serwer nginx pełniący rolę load balancera

Architektura

- aplikacja web komunikuje się z bazą danych PostgreSQL
- nginx działa jako reverse proxy i przekazuje ruch do aplikacji
- wszystkie kontenery działają w jednej sieci Docker (app-network)
- dane bazy danych są przechowywane w volume (postgres-data)

Docker

Zostały utworzone:
- kontenery: nginx-lb, web-app, postgres-db
- sieć: app-network
- volume: postgres-data

Weryfikacja działania

Sprawdzenie połączenia przez nginx:

curl http://localhost:8080

Wynik:

Web app works. Connected to PostgreSQL...

Dodatkowo sprawdzono komunikację między kontenerami:

docker exec -it nginx-lb curl http://web-app:5000

Terraform

Została przygotowana konfiguracja Terraform obejmująca:
- docker_container
- docker_network
- docker_volume

Wykonano:

terraform init
terraform plan

Import zasobów

Przeprowadzono proces importu istniejących zasobów do Terraform:

terraform import docker_container.nginx <ID>  
terraform import docker_container.web <ID>  
terraform import docker_container.postgres <ID>  

Proces importu został wykonany w celu integracji istniejącej infrastruktury Docker
z konfiguracją Terraform oraz jej odwzorowania w modelu deklaratywnym.

Następnie infrastruktura została odwzorowana w sposób deklaratywny
w pliku main.tf zgodnie z podejściem Infrastructure as Code.

Struktura projektu

iac-homework/
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── nginx/
│   └── default.conf
├── terraform/
│   ├── main.tf
│   ├── terraform.tf
│   ├── variables.tf
│   └── outputs.tf

Best practices

- podział aplikacji na warstwy (web, db, proxy)
- wykorzystanie sieci Docker zamiast localhost
- użycie volume dla trwałości danych
- Infrastructure as Code (Terraform)

Uwagi

Projekt został uruchomiony lokalnie w środowisku Docker.
Terraform został użyty do odwzorowania infrastruktury.
Projekt ma charakter demonstracyjny i edukacyjny.

Podsumowanie

Projekt przedstawia budowę środowiska multi-container w Docker
oraz jego odwzorowanie w Terraform zgodnie z podejściem IaC.
