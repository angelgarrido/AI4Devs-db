# Esquema de Base de Datos

Este documento describe el esquema de la base de datos del sistema de seguimiento de talento.

## Diagrama ER

```mermaid
erDiagram
    %% Entidades de normalización
    StatusType {
        int id PK
        string name
        string category
    }

    Address {
        int id PK
        string street
        string city
        string state
        string country
        string postalCode
    }

    EmploymentType {
        int id PK
        string name
    }

    ContactInfo {
        int id PK
        string email
        string phone
        int positionId FK
    }

    %% Entidades principales
    Company {
        int id PK
        string name
        text description
    }

    Candidate {
        int id PK
        string firstName
        string lastName
        string email
        string phone
        int addressId FK
    }

    Education {
        int id PK
        string institution
        string title
        datetime startDate
        datetime endDate
        int candidateId FK
    }

    WorkExperience {
        int id PK
        string company
        string position
        string description
        datetime startDate
        datetime endDate
        int candidateId FK
    }

    Resume {
        int id PK
        string filePath
        string fileType
        datetime uploadDate
        int candidateId FK
    }

    Employee {
        int id PK
        int companyId FK
        string name
        string email
        string role
        boolean isActive
    }

    Position {
        int id PK
        int companyId FK
        int interviewFlowId FK
        int addressId FK
        int employmentTypeId FK
        int statusId FK
        string title
        text description
        boolean isVisible
        text jobDescription
        text requirements
        text responsibilities
        decimal salaryMin
        decimal salaryMax
        text benefits
        datetime applicationDeadline
    }

    InterviewFlow {
        int id PK
        string description
    }

    InterviewStep {
        int id PK
        int interviewFlowId FK
        int interviewTypeId FK
        string name
        int orderIndex
    }

    InterviewType {
        int id PK
        string name
        text description
    }

    Application {
        int id PK
        int positionId FK
        int candidateId FK
        int statusId FK
        datetime applicationDate
        text notes
    }

    Interview {
        int id PK
        int applicationId FK
        int interviewStepId FK
        int employeeId FK
        datetime interviewDate
        string result
        int score
        text notes
    }

    %% Relaciones
    Company ||--o{ Employee : employs
    Company ||--o{ Position : offers
    Candidate ||--o{ Education : has
    Candidate ||--o{ WorkExperience : has
    Candidate ||--o{ Resume : has
    Candidate ||--o{ Application : submits
    Candidate }|--|| Address : has
    Position ||--|| InterviewFlow : assigns
    Position ||--|| Address : located_at
    Position ||--|| EmploymentType : has
    Position ||--|| StatusType : has
    Position ||--|| ContactInfo : has
    Position ||--o{ Application : receives
    InterviewFlow ||--o{ InterviewStep : contains
    InterviewStep ||--|| InterviewType : uses
    InterviewStep ||--o{ Interview : has
    Application ||--|| StatusType : has
    Application ||--o{ Interview : has
    Employee ||--o{ Interview : conducts
```

## Descripción de Entidades

### Entidades de Normalización

1. **StatusType**
   - Almacena los diferentes estados para posiciones y aplicaciones
   - Categoría indica si el estado es para posición o aplicación

2. **Address**
   - Almacena direcciones normalizadas
   - Usado tanto por Candidate como por Position

3. **EmploymentType**
   - Tipos de empleo disponibles
   - Relacionado con Position

4. **ContactInfo**
   - Información de contacto para posiciones
   - Relación uno a uno con Position

### Entidades Principales

1. **Company**
   - Información de la empresa
   - Relacionada con Employee y Position

2. **Candidate**
   - Información del candidato
   - Relacionada con Education, WorkExperience, Resume y Application

3. **Position**
   - Información de la posición
   - Relacionada con Company, InterviewFlow, Address, EmploymentType y StatusType

4. **Application**
   - Aplicaciones de candidatos a posiciones
   - Relacionada con Position, Candidate y StatusType

5. **Interview**
   - Entrevistas realizadas
   - Relacionada con Application, InterviewStep y Employee

## Índices

### Índices de Búsqueda Frecuente

- Candidate: email, addressId
- Position: companyId+statusId, addressId, employmentTypeId, applicationDeadline, isVisible
- Application: positionId, candidateId, statusId, applicationDate
- Interview: applicationId, interviewStepId, employeeId, interviewDate

### Índices de Ordenamiento

- InterviewStep: orderIndex

### Índices de Relaciones

- Todas las claves foráneas tienen sus índices correspondientes
