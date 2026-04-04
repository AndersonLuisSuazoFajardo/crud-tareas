# ◈ TaskFlow — Gestor de Tareas CRUD

Aplicación CRUD funcional desarrollada con HTML, CSS y JavaScript puro.  
Permite crear, leer, actualizar y eliminar tareas con persistencia en `localStorage`.

---

## 🚀 Funcionalidades

- **Crear** tareas con título, descripción, prioridad y fecha límite
- **Leer** y filtrar tareas por estado y prioridad
- **Actualizar** cualquier tarea existente
- **Eliminar** con confirmación en modal
- Marcar tareas como completadas
- Búsqueda en tiempo real
- Indicador de tareas vencidas
- Persistencia con `localStorage`
- Diseño responsive

---

## 🗂️ Estructura del proyecto

```
crud-tareas/
├── index.html
├── css/
│   └── styles.css
├── js/
│   └── app.js
└── README.md
```

---

## 🌿 Flujo de trabajo — Git Flow

Este proyecto sigue la metodología **Git Flow**:

### Ramas principales
| Rama | Propósito |
|------|-----------|
| `main` | Producción estable |
| `developer` | Integración de features |
| `qa` | Control de calidad |

### Ramas de features y hotfixes
| Rama | Descripción |
|------|-------------|
| `feature/task-form` | Formulario de creación de tareas |
| `feature/task-list` | Listado y renderizado de tareas |
| `feature/filters-search` | Filtros y búsqueda |
| `feature/local-storage` | Persistencia con localStorage |
| `hotfix/fix-date-format` | Corrección del formato de fechas |

### Flujo de PR por rama
Cada rama genera 3 Pull Requests:
1. `feature/X` → `developer`
2. `feature/X` → `qa`
3. `feature/X` → `main`

---

## ▶️ Cómo usar

1. Clona el repositorio:
   ```bash
   git clone https://github.com/AndersonLuisSuazoFajardo/crud-tareas.git
   ```
2. Abre `index.html` en tu navegador.
3. ¡Listo! No requiere instalación ni servidor.

---

## 🛠️ Tecnologías

- HTML5
- CSS3 (variables, grid, animaciones)
- JavaScript ES6+ (sin frameworks)
- localStorage API

---

*Proyecto académico — Metodología Git Flow*
