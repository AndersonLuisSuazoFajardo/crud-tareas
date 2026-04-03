# 🌿 GUÍA COMPLETA — GIT FLOW PASO A PASO
# Proyecto: TaskFlow CRUD
# Sigue este archivo en orden. ¡No te saltes pasos!

# ════════════════════════════════════════════
# PASO 0 — CONFIGURACIÓN INICIAL
# ════════════════════════════════════════════

# 1. Crea un repositorio NUEVO en GitHub:
#    → Ve a github.com → New repository
#    → Nombre: crud-tareas
#    → Visibility: Public
#    → NO marques "Initialize with README" (lo haremos nosotros)
#    → Click en "Create repository"

# 2. En tu computadora, abre una terminal en la carpeta del proyecto:
git init
git remote add origin https://github.com/TU_USUARIO/crud-tareas.git

# (Reemplaza TU_USUARIO con tu nombre de usuario de GitHub)


# ════════════════════════════════════════════
# PASO 1 — PRIMER COMMIT EN MAIN
# ════════════════════════════════════════════

git add .
git commit -m "chore: initial project structure"
git branch -M main
git push -u origin main


# ════════════════════════════════════════════
# PASO 2 — CREAR RAMAS BASE (developer y qa)
# ════════════════════════════════════════════

git checkout -b developer
git push -u origin developer

git checkout -b qa
git push -u origin qa

# Volvemos a main para empezar el flujo
git checkout main


# ════════════════════════════════════════════
# FEATURE 1 — task-form
# ════════════════════════════════════════════

git checkout developer
git checkout -b feature/task-form

# Edita index.html: añade este comentario al final del <form-panel>
# <!-- feature/task-form: formulario de creación implementado -->
git add .
git commit -m "feat: add task creation form with validation"
git push -u origin feature/task-form

# ─── PR 1.1: feature/task-form → developer ───────────────────
# Ve a GitHub → Pull Requests → New pull request
# base: developer  |  compare: feature/task-form
# Título: "feat: task form → developer"
# → Create pull request → Merge pull request → Confirm merge → (borra la rama en GitHub si quieres, pero NO localmente aún)

# ─── PR 1.2: feature/task-form → qa ─────────────────────────
# base: qa  |  compare: feature/task-form
# Título: "feat: task form → qa"
# → Create pull request → Merge pull request → Confirm merge

# ─── PR 1.3: feature/task-form → main ───────────────────────
# base: main  |  compare: feature/task-form
# Título: "feat: task form → main"
# → Create pull request → Merge pull request → Confirm merge


# ════════════════════════════════════════════
# FEATURE 2 — task-list
# ════════════════════════════════════════════

git checkout developer
git pull origin developer
git checkout -b feature/task-list

# Edita js/app.js: añade este comentario al final del archivo
# // feature/task-list: renderizado de tarjetas implementado
git add .
git commit -m "feat: implement task list rendering and card UI"
git push -u origin feature/task-list

# ─── PR 2.1: feature/task-list → developer ───────────────────
# base: developer  |  compare: feature/task-list
# Título: "feat: task list → developer"
# → Merge

# ─── PR 2.2: feature/task-list → qa ─────────────────────────
# base: qa  |  compare: feature/task-list
# Título: "feat: task list → qa"
# → Merge

# ─── PR 2.3: feature/task-list → main ───────────────────────
# base: main  |  compare: feature/task-list
# Título: "feat: task list → main"
# → Merge


# ════════════════════════════════════════════
# FEATURE 3 — filters-search
# ════════════════════════════════════════════

git checkout developer
git pull origin developer
git checkout -b feature/filters-search

# Edita css/styles.css: añade este comentario al final
# /* feature/filters-search: estilos de filtros y búsqueda */
git add .
git commit -m "feat: add search and filter functionality"
git push -u origin feature/filters-search

# ─── PR 3.1: feature/filters-search → developer ──────────────
# Título: "feat: filters and search → developer"
# → Merge

# ─── PR 3.2: feature/filters-search → qa ─────────────────────
# Título: "feat: filters and search → qa"
# → Merge

# ─── PR 3.3: feature/filters-search → main ───────────────────
# Título: "feat: filters and search → main"
# → Merge


# ════════════════════════════════════════════
# FEATURE 4 — local-storage
# ════════════════════════════════════════════

git checkout developer
git pull origin developer
git checkout -b feature/local-storage

# Edita js/app.js: añade este comentario justo después de "let tasks = [];"
# // feature/local-storage: persistencia activada
git add .
git commit -m "feat: add localStorage persistence for tasks"
git push -u origin feature/local-storage

# ─── PR 4.1: feature/local-storage → developer ───────────────
# Título: "feat: localStorage persistence → developer"
# → Merge

# ─── PR 4.2: feature/local-storage → qa ─────────────────────
# Título: "feat: localStorage persistence → qa"
# → Merge

# ─── PR 4.3: feature/local-storage → main ───────────────────
# Título: "feat: localStorage persistence → main"
# → Merge


# ════════════════════════════════════════════
# HOTFIX — fix-date-format
# ════════════════════════════════════════════

# Este hotfix simula una corrección urgente en producción.
# Los hotfix nacen desde MAIN (no desde developer)

git checkout main
git pull origin main
git checkout -b hotfix/fix-date-format

# Edita js/app.js: modifica la función formatDate así:
# function formatDate(dateStr) {
#   if (!dateStr) return '';
#   const [y, m, d] = dateStr.split('-');
#   return `${d}/${m}/${y}`; // hotfix: validación de fecha nula agregada
# }
git add .
git commit -m "hotfix: fix null date crash in formatDate function"
git push -u origin hotfix/fix-date-format

# ─── PR 5.1: hotfix/fix-date-format → developer ──────────────
# Título: "hotfix: fix date format → developer"
# → Merge

# ─── PR 5.2: hotfix/fix-date-format → qa ─────────────────────
# Título: "hotfix: fix date format → qa"
# → Merge

# ─── PR 5.3: hotfix/fix-date-format → main ───────────────────
# Título: "hotfix: fix date format → main"
# → Merge


# ════════════════════════════════════════════
# PASO FINAL — VERIFICACIÓN
# ════════════════════════════════════════════

# Actualiza tu rama main local con todos los cambios
git checkout main
git pull origin main

# Verifica el historial de commits
git log --oneline --graph --all

# ════════════════════════════════════════════
# RESUMEN DE PULL REQUESTS (15 en total)
# ════════════════════════════════════════════
#
#  FEATURE/HOTFIX              → BASE        TÍTULO SUGERIDO
#  ─────────────────────────────────────────────────────────
#  feature/task-form           → developer   feat: task form → developer
#  feature/task-form           → qa          feat: task form → qa
#  feature/task-form           → main        feat: task form → main
#
#  feature/task-list           → developer   feat: task list → developer
#  feature/task-list           → qa          feat: task list → qa
#  feature/task-list           → main        feat: task list → main
#
#  feature/filters-search      → developer   feat: filters and search → developer
#  feature/filters-search      → qa          feat: filters and search → qa
#  feature/filters-search      → main        feat: filters and search → main
#
#  feature/local-storage       → developer   feat: localStorage → developer
#  feature/local-storage       → qa          feat: localStorage → qa
#  feature/local-storage       → main        feat: localStorage → main
#
#  hotfix/fix-date-format      → developer   hotfix: fix date format → developer
#  hotfix/fix-date-format      → qa          hotfix: fix date format → qa
#  hotfix/fix-date-format      → main        hotfix: fix date format → main
#
#  TOTAL: 15 Pull Requests ✓ (todos deben quedar en estado Closed/Merged)
