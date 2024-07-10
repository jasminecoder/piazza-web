import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['menu', 'button', 'userMenuButton', 'userMenu', 'navLink']

  connect() {
    this.buttonTarget.addEventListener('click', () => this.toggleMenu())
    this.userMenuButtonTarget.addEventListener('click', () =>
      this.toggleUserMenu()
    )
    document.addEventListener('click', (event) => this.closeMenus(event))
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden')
    // this.menuTarget.classList.toggle('block')
    this.buttonTarget.classList.toggle('is-active')
  }

  toggleUserMenu() {
    this.userMenuTarget.classList.toggle('hidden')
  }

  closeMenus(event) {
    if (
      !this.userMenuButtonTarget.contains(event.target) &&
      !this.userMenuTarget.contains(event.target)
    ) {
      this.userMenuTarget.classList.add('hidden')
    }
    if (
      !this.buttonTarget.contains(event.target) &&
      !this.menuTarget.contains(event.target)
    ) {
      this.menuTarget.classList.add('hidden')
      this.buttonTarget.classList.remove('is-active')
    }
  }
}
