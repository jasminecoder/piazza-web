// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
// COMMENT:Toggle mobile navigation menu

// document.addEventListener('DOMContentLoaded', () => {
// COMMENT: Get the "navbar-burger" element
// const navbarBurger = document.querySelector('.navbar-burger')

// COMMENT:Add a click event on the "navbar-burger"
// navbarBurger.addEventListener('click', () => {
// COMMENT:Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
// navbarBurger.classList.toggle('is-active')
// const target = navbarBurger.dataset.target
// const navbarMenu = document.getElementById(target)
// navbarMenu.classList.toggle('is-active')
// })

// COMMENT:Get the "user-menu-button" element
// const userMenuButton = document.getElementById('user-menu-button')
// const userDropdown = document.getElementById('user-dropdown')

// COMMENT:Add a click event on the "user-menu-button"
// userMenuButton.addEventListener('click', () => {
// userDropdown.classList.toggle('hidden')
// userDropdown.classList.toggle('block')
// })

// COMMENT:Close user dropdown when clicking outside
// document.addEventListener('click', (event) => {
// if (
// !userMenuButton.contains(event.target) &&
// !userDropdown.contains(event.target)
// ) {
// userDropdown.classList.add('hidden')
// userDropdown.classList.remove('block')
// }
// })
// })
