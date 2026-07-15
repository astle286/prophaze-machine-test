# Order Service - CI/CD + Observability with GitLab

![Java](https://img.shields.io/badge/Java-21-blue)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.x-green)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED)
![Helm](https://img.shields.io/badge/Helm-3-blueviolet)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-326CE5)
![Prometheus](https://img.shields.io/badge/Monitoring-Prometheus-orange)
![Grafana](https://img.shields.io/badge/Dashboard-Grafana-F46800)

A Spring Boot REST API demonstrating a complete CI/CD pipeline, containerization, Kubernetes deployment with Helm, and observability using Prometheus and Grafana.
# Screenshots

---

## API Endpoints

### Orders Endpoint

![Orders Endpoint](screenshots/endpoint-orders.png)

---

### Version Endpoint

![Version Endpoint](screenshots/endpoint-version.png)

---

### Health Endpoint

![Health Endpoint](screenshots/endpoint-health.png)

---

## Docker

Running containers

![Docker Containers](screenshots/docker-containers.png)

---

## Prometheus

### Metrics Endpoint

![Prometheus Metrics](screenshots/prometheus-metrics.png)

---

### Prometheus Target Status

![Prometheus Status](screenshots/prometheus-status.png)

---

## Grafana

Application dashboard

![Grafana Dashboard](screenshots/grafana-dashboard.png)

---

## Health Check using curl

Docker health verification

![Health Check](screenshots/curl-health.png)

---

## Project Overview

This project was built as part of a DevOps machine test.

It demonstrates:

- Spring Boot REST API
- Docker containerization (non-root user + healthcheck)
- GitLab CI/CD pipeline
- Helm deployment to Kubernetes
- Prometheus metrics
- Grafana dashboard
- Security scanning using ggshield and Trivy

---

# Architecture

```text
                    GitLab Repository
                           │
                           ▼
                    GitLab CI/CD Pipeline
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
 Secret Scan (ggshield)               Trivy Scan
        │                                     │
        └──────────────┬──────────────────────┘
                       ▼
                  Maven Build & Test
                       ▼
                Docker Image Build
                       ▼
                Push Image to Registry
                       ▼
               Helm Upgrade --install
                       ▼
              Kubernetes (dev namespace)
                       ▼
                Spring Boot Application
                       │
       /actuator/prometheus metrics
                       ▼
                  Prometheus Server
                       ▼
                    Grafana Dashboard
```

---

# Features

## REST API

| Endpoint | Description |
|----------|-------------|
| `/orders` | Returns sample order data |
| `/actuator/health` | Health endpoint |
| `/actuator/info` | Application version |
| `/actuator/prometheus` | Prometheus metrics |

---

## Docker

Features:

- Java 21
- Non-root user
- Healthcheck
- Small runtime image

Build image

```bash
docker build -t order-service .
```

Run container

```bash
docker run -d -p 8080:8080 order-service
```

Verify

```
http://localhost:8080/orders
```

---

# Local Development

Run locally

```bash
mvn spring-boot:run
```

Build

```bash
mvn clean package
```

Run tests

```bash
mvn test
```

---

# Helm Chart

The application is deployed using Helm.

Resources included:

- Deployment
- Service
- ServiceAccount
- Ingress
- Values.yaml
- Common helper templates

Validate chart

```bash
helm lint ./helm
```

Install

```bash
helm install order-service ./helm
```

Upgrade

```bash
helm upgrade --install order-service ./helm
```

---

# GitLab CI/CD Pipeline

Pipeline stages

```
scan
│
├── ggshield
└── Trivy
        │
build/test
        │
docker build
        │
image push
        │
deploy_dev (Helm)
        │
smoke_dev
```

Pipeline performs:

- Secret scanning (ggshield)
- Filesystem vulnerability scanning (Trivy)
- Maven build
- Unit tests
- Docker image build
- Image push to GitLab Container Registry
- Helm deployment
- Smoke testing

---

# Observability

## Prometheus

Metrics exposed from

```
/actuator/prometheus
```

Prometheus scrapes metrics every 15 seconds.

---

## Grafana Dashboard

Dashboard includes

- Application Status
- Requests / Second
- 95th Percentile Latency
- Requests by Endpoint

---

# Project Structure

```
order-service
│
├── src
│   ├── main
│   └── test
│
├── helm
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates
│
├── prometheus
│   └── prometheus.yml
│
├── grafana
│   └── dashboard.json
│
├── Dockerfile
├── docker-compose.yml
├── .gitlab-ci.yml
├── pom.xml
└── README.md
```

---

# Technologies Used

- Java 21
- Spring Boot
- Maven
- Docker
- GitLab CI/CD
- Helm
- Kubernetes
- Prometheus
- Grafana
- ggshield
- Trivy

---


# Sample API Response

## GET /orders

```json
[
  {
    "id": 1,
    "customer": "John",
    "amount": 1200.0
  },
  {
    "id": 2,
    "customer": "Alice",
    "amount": 850.0
  },
  {
    "id": 3,
    "customer": "Bob",
    "amount": 450.0
  }
]
```

---

# Bonus

NGINX Ingress rate limiting is configured using annotations:

```yaml
nginx.ingress.kubernetes.io/limit-rps: "10"
nginx.ingress.kubernetes.io/limit-burst-multiplier: "2"
```


---

# Author

**ASTLE E M**