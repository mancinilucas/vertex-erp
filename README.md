# Vertex - ERP para Professores Autônomos

Visão geral

Este projeto é uma refatoração e reimplementação de um ERP leve para gestão de cursos, focado em professores autônomos. A ideia é oferecer uma plataforma simples e prática para gerenciar alunos, turmas, notas, finanças e operações do dia-a-dia, com uma API robusta no backend e uma aplicação cliente separada.

Objetivos principais

- Cadastro e gestão de alunos, turmas e cursos
- Controle de notas, frequências e métricas individuais por aluno
- Gestão financeira (receitas, cobranças, faturas) para cada professor
- Agendamento de aulas e calendário / integração com serviços externos
- Relatórios e dashboards para acompanhar performance e receita

Stack técnica

Backend
- Java 21
- Spring Boot 4+
- PostgreSQL
- Migrations: Flyway
- Empacotamento: Maven (mvnw)

Infra / DevOps
- Dockerfile para container de produção
- CI/CD: GitHub Actions
- Hospedagem: AWS

Pré-requisitos:
- JDK 21
- Docker (opcional)
- Maven wrapper (incluído)

Executando a API localmente:

1. Build e testes:

```bash
./mvnw clean package
```

2. Rodar a aplicação:

```bash
./mvnw spring-boot:run
```

A API por padrão escuta na porta 8080 (configuração via `src/main/resources/application.properties` ou perfis `application-dev.yml`).

Executando com Docker (produção):

```bash
docker build -t vertex:latest .
docker run -p 8080:8080 --env SPRING_PROFILES_ACTIVE=prod vertex:latest
```

Estrutura do repositório

- `src/main/java` - código fonte do backend (pacote `com.app.vertex`)
- `src/main/resources` - configurações e recursos
- `Dockerfile` - imagem otimizada multi-stage
- `pom.xml` - dependências e build

