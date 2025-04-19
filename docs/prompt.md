# Prompts Utilizados en el Proyecto

Este documento recopila todos los prompts utilizados durante el desarrollo del proyecto de sistema de seguimiento de talento.

## 1. Análisis Inicial del Proyecto

```text
Actua como un Architecto de Sistemas y DBA experto en el diseño de sistemas escalables usando DDD, Eres experto usando base de datos relacionales y modificando sus estructuras.
Has sido contratada para asistir y guiar en las decisiones relacionadas con la actualización de la base de datos con nuevas entidades:

El proyecto es un proyecto con React en el en frontend y Express con prisma en el backend. Lee el readme del proyecto y analiza el proyecto para crear la base de conocimiento que utilizaremos en los siguientes ejercicios.
```

## 2. Análisis del Nuevo Esquema de Base de Datos

```text
Uno de los requerimientos del proyecto es modificar la base de datos siguiendo el siguiente esquema. 

Antes de modificar vamos a analizar que cambios se aplican a la base de datos con el nuevo esquema. 

"erDiagram
     COMPANY {
         int id PK
         string name
     }
     EMPLOYEE {
         int id PK
         int company_id FK
         string name
         string email
         string role
         boolean is_active
     }
     POSITION {
         int id PK
         int company_id FK
         int interview_flow_id FK
         string title
         text description
         string status
         boolean is_visible
         string location
         text job_description
         text requirements
         text responsibilities
         numeric salary_min
         numeric salary_max
         string employment_type
         text benefits
         text company_description
         date application_deadline
         string contact_info
     }
     INTERVIEW_FLOW {
         int id PK
         string description
     }
     INTERVIEW_STEP {
         int id PK
         int interview_flow_id FK
         int interview_type_id FK
         string name
         int order_index
     }
     INTERVIEW_TYPE {
         int id PK
         string name
         text description
     }
     CANDIDATE {
         int id PK
         string firstName
         string lastName
         string email
         string phone
         string address
     }
     APPLICATION {
         int id PK
         int position_id FK
         int candidate_id FK
         date application_date
         string status
         text notes
     }
     INTERVIEW {
         int id PK
         int application_id FK
         int interview_step_id FK
         int employee_id FK
         date interview_date
         string result
         int score
         text notes
     }

     COMPANY ||--o{ EMPLOYEE : employs
     COMPANY ||--o{ POSITION : offers
     POSITION ||--|| INTERVIEW_FLOW : assigns
     INTERVIEW_FLOW ||--o{ INTERVIEW_STEP : contains
     INTERVIEW_STEP ||--|| INTERVIEW_TYPE : uses
     POSITION ||--o{ APPLICATION : receives
     CANDIDATE ||--o{ APPLICATION : submits
     APPLICATION ||--o{ INTERVIEW : has
     INTERVIEW ||--|| INTERVIEW_STEP : consists_of
     EMPLOYEE ||--o{ INTERVIEW : conducts"
```

## 3. Combinación de Esquemas y Normalización

```text
Mergea ambos scripts, si queremos seguir manteniendo las relaciones con Education, WorkExperience y Resume, además de añadir las nuevas tablas, campos y relaciones, como por ejemplo "Company, Employee, Position, Interview with their step, etc...)

Analiza todo lo necesario para que esta estructura cumpla 3NF en esta base de datos relacional (Third normal Form)
```

## 4. Implementación de Cambios en la Base de Datos

```text
Implementemos estos cambios en la base de datos. 
1. Genera los cambios de modelo backend/prisma/schema.prisma
2. Genera la migración de la base de datos.
```

## 5. Análisis Final del Esquema

```text
Para finalizar, vamos a analizar de nuevo el esquema actual. 
- Identifica si hay datos redundantes o no normalizados
- Identifica si hay cambios adicionales para simplificar y/o mejorar la estrcutura de la base de datos 
- Analiza los indices que hemos creado para verificar que son los más adecuados.
```

## 6. Implementación de Mejoras Identificadas

```text
Ejecuta los siguientes cambios que identificas: 
1. Mueve "CompanyDescription" a "company" en lugar de en estar en Position
2. No crees crea referencias en "WorkExperience" a "Company" y "Position". "Company" y "position2" hacen referencia a las empresas que son clientes del sistema, y las relacionadas con "Work Experience", son relativas al aplicante. Las considero entidades independientes. 
3. Normaliza "contact Info" en "Position". 
4. Normaliza los estados de "position" y "application"
5. Normaliza "Location" como Dirección (Address) normalizalo tambien en  normalizado tambien en "Candidate" "Address"
6. Normaliza "EmploymentType"
7. No separes el rango salarial de la posición
8. Añade los indices de busquedas y ordnamiento y filtrado que recomiendas
```

## 7. Creación de Documentación

```text
genera un documento en docs/database.md con el esquema en mermaid de la base de datos actual.
```

## 8. Recopilación de Prompts

```text
Crea un listado de todos los prompts que te he solicitado en este proyecto hemos utilizado en el fichero /docs/prompts.md
```
