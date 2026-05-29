/**
 * Métodos Numéricos - Sitio Web Académico
 * Archivo: main.js
 * Descripción: Funcionalidad global compartida (menú hamburguesa, scroll suave, enlace activo).
 */

document.addEventListener('DOMContentLoaded', function () {

  // ==========================================================================
  // 1. HAMBURGER MENU - Toggle para navegación móvil
  // ==========================================================================
  const hamburger = document.querySelector('.hamburger');
  const nav = document.querySelector('.nav');

  if (hamburger && nav) {
    hamburger.addEventListener('click', function () {
      this.classList.toggle('active');
      nav.classList.toggle('open');
      const isOpen = nav.classList.contains('open');
      this.setAttribute('aria-expanded', isOpen);
    });

    // Cerrar menú al hacer clic en un enlace
    document.querySelectorAll('.nav__link').forEach(function (link) {
      link.addEventListener('click', function () {
        hamburger.classList.remove('active');
        nav.classList.remove('open');
        hamburger.setAttribute('aria-expanded', 'false');
      });
    });
  }

  // ==========================================================================
  // 2. ENLACE ACTIVO - Resaltar página actual en la navegación
  // ==========================================================================
  const currentPage = window.location.pathname.split('/').pop() || 'index.html';

  document.querySelectorAll('.nav__link').forEach(function (link) {
    const linkHref = link.getAttribute('href');
    if (linkHref === currentPage) {
      link.classList.add('nav__link--active');
    } else {
      link.classList.remove('nav__link--active');
    }
  });

  // ==========================================================================
  // 3. SCROLL SUAVE - Para todos los enlaces internos con ancla
  // ==========================================================================
  document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
    anchor.addEventListener('click', function (e) {
      const targetId = this.getAttribute('href');
      if (targetId === '#') return;
      const target = document.querySelector(targetId);
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  // ==========================================================================
  // 4. FAQ ACCORDION - Expandir/colapsar preguntas frecuentes
  // ==========================================================================
  document.querySelectorAll('.faq-item__question').forEach(function (question) {
    question.addEventListener('click', function () {
      const isExpanded = this.getAttribute('aria-expanded') === 'true';
      const answer = this.nextElementSibling;

      // Cerrar otros abiertos
      document.querySelectorAll('.faq-item__question').forEach(function (q) {
        if (q !== question) {
          q.setAttribute('aria-expanded', 'false');
          q.nextElementSibling.classList.remove('open');
        }
      });

      if (isExpanded) {
        this.setAttribute('aria-expanded', 'false');
        answer.classList.remove('open');
      } else {
        this.setAttribute('aria-expanded', 'true');
        answer.classList.add('open');
      }
    });
  });

  // ==========================================================================
  // 5. YEAR AUTOMÁTICO - Para el copyright
  // ==========================================================================
  const yearSpan = document.getElementById('current-year');
  if (yearSpan) {
    yearSpan.textContent = new Date().getFullYear();
  }

});
