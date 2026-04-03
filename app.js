/* ============================================
   TaskFlow — app.js
   CRUD completo con localStorage
   ============================================ */

// ── Estado global ──────────────────────────
let tasks = [];
let editingId = null;
let deletingId = null;

// ── Inicialización ─────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  loadTasks();
  renderTasks();
  setDefaultDate();
});

function setDefaultDate() {
  const today = new Date().toISOString().split('T')[0];
  document.getElementById('task-due').value = today;
}

// ── LocalStorage ───────────────────────────
function loadTasks() {
  const stored = localStorage.getItem('taskflow_tasks');
  tasks = stored ? JSON.parse(stored) : [];
}

function saveTasks() {
  localStorage.setItem('taskflow_tasks', JSON.stringify(tasks));
}

// ── CRUD ───────────────────────────────────

/** CREATE / UPDATE */
function saveTask() {
  const title    = document.getElementById('task-title').value.trim();
  const desc     = document.getElementById('task-desc').value.trim();
  const priority = document.getElementById('task-priority').value;
  const due      = document.getElementById('task-due').value;

  // Validación
  if (!title) {
    showMessage('El título es obligatorio.', 'error');
    document.getElementById('task-title').focus();
    return;
  }

  if (editingId) {
    // UPDATE
    const idx = tasks.findIndex(t => t.id === editingId);
    if (idx !== -1) {
      tasks[idx] = { ...tasks[idx], title, desc, priority, due, updatedAt: Date.now() };
      showMessage('Tarea actualizada ✓', 'success');
    }
    cancelEdit();
  } else {
    // CREATE
    const newTask = {
      id:        crypto.randomUUID(),
      title,
      desc,
      priority,
      due,
      status:    'pendiente',
      createdAt: Date.now(),
      updatedAt: Date.now(),
    };
    tasks.unshift(newTask);
    showMessage('Tarea creada ✓', 'success');
    clearForm();
  }

  saveTasks();
  renderTasks();
}

/** READ — render lista */
function renderTasks() {
  const search   = document.getElementById('search-input').value.toLowerCase();
  const statusF  = document.getElementById('filter-status').value;
  const priorityF = document.getElementById('filter-priority').value;

  let filtered = tasks.filter(t => {
    const matchSearch   = t.title.toLowerCase().includes(search) ||
                          t.desc.toLowerCase().includes(search);
    const matchStatus   = statusF   === 'todas' || t.status === statusF;
    const matchPriority = priorityF === 'todas' || t.priority === priorityF;
    return matchSearch && matchStatus && matchPriority;
  });

  const container = document.getElementById('task-list');
  const count = document.getElementById('task-count');
  count.textContent = `${tasks.length} tarea${tasks.length !== 1 ? 's' : ''}`;

  if (filtered.length === 0) {
    container.innerHTML = `
      <div class="empty-state">
        <span class="empty-icon">◌</span>
        <p>${tasks.length === 0 ? 'No hay tareas aún.<br/>¡Agrega la primera!' : 'Sin resultados para este filtro.'}</p>
      </div>`;
    return;
  }

  container.innerHTML = filtered.map(task => buildCard(task)).join('');
}

function buildCard(task) {
  const isCompleted = task.status === 'completada';
  const overdueClass = isOverdue(task) && !isCompleted ? 'badge-overdue' : 'badge-date';
  const dueLbl = task.due ? formatDate(task.due) : '';

  return `
    <div class="task-card ${isCompleted ? 'completed' : ''}" id="card-${task.id}">
      <input
        type="checkbox"
        class="task-check"
        ${isCompleted ? 'checked' : ''}
        onchange="toggleStatus('${task.id}')"
        title="Marcar como ${isCompleted ? 'pendiente' : 'completada'}"
      />
      <div class="task-body">
        <div class="task-title">${escapeHtml(task.title)}</div>
        ${task.desc ? `<div class="task-desc">${escapeHtml(task.desc)}</div>` : ''}
        <div class="task-meta">
          <span class="badge badge-${task.priority}">${task.priority}</span>
          ${dueLbl ? `<span class="badge ${overdueClass}">${isOverdue(task) && !isCompleted ? '⚠ ' : ''}${dueLbl}</span>` : ''}
        </div>
      </div>
      <div class="task-actions">
        <button class="btn btn-edit" onclick="startEdit('${task.id}')">Editar</button>
        <button class="btn btn-delete" onclick="requestDelete('${task.id}')">Borrar</button>
      </div>
    </div>`;
}

/** UPDATE — cargar en form */
function startEdit(id) {
  const task = tasks.find(t => t.id === id);
  if (!task) return;

  editingId = id;
  document.getElementById('task-title').value    = task.title;
  document.getElementById('task-desc').value     = task.desc;
  document.getElementById('task-priority').value = task.priority;
  document.getElementById('task-due').value      = task.due;

  document.getElementById('form-mode-label').textContent = 'Editar Tarea';
  document.getElementById('btn-cancel').style.display = 'inline-flex';
  document.getElementById('task-title').focus();
  document.querySelector('.form-panel').scrollIntoView({ behavior: 'smooth' });
}

function cancelEdit() {
  editingId = null;
  clearForm();
  document.getElementById('form-mode-label').textContent = 'Nueva Tarea';
  document.getElementById('btn-cancel').style.display = 'none';
}

/** Toggle estado */
function toggleStatus(id) {
  const idx = tasks.findIndex(t => t.id === id);
  if (idx === -1) return;
  tasks[idx].status = tasks[idx].status === 'completada' ? 'pendiente' : 'completada';
  tasks[idx].updatedAt = Date.now();
  saveTasks();
  renderTasks();
}

/** DELETE — modal confirm */
function requestDelete(id) {
  deletingId = id;
  document.getElementById('modal-overlay').classList.add('open');
}

function confirmDelete() {
  if (!deletingId) return;
  tasks = tasks.filter(t => t.id !== deletingId);
  deletingId = null;
  closeModal();
  saveTasks();
  renderTasks();
  showMessage('Tarea eliminada.', 'success');
}

function closeModal() {
  deletingId = null;
  document.getElementById('modal-overlay').classList.remove('open');
}

// ── Helpers ────────────────────────────────
function clearForm() {
  document.getElementById('task-title').value    = '';
  document.getElementById('task-desc').value     = '';
  document.getElementById('task-priority').value = 'media';
  setDefaultDate();
}

function showMessage(msg, type) {
  const el = document.getElementById('form-message');
  el.textContent = msg;
  el.className   = `form-message ${type}`;
  setTimeout(() => { el.textContent = ''; el.className = 'form-message'; }, 3000);
}

function escapeHtml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function formatDate(dateStr) {
  const [y, m, d] = dateStr.split('-');
  return `${d}/${m}/${y}`;
}

function isOverdue(task) {
  if (!task.due) return false;
  const today = new Date().toISOString().split('T')[0];
  return task.due < today;
}

// Cerrar modal con Escape
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') closeModal();
});
