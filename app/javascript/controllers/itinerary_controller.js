 import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itinerary-form"
export default class extends Controller {
  static targets = ['loader', 'message']

  connect() {
    setTimeout(() => {
      this.loadItinerary()
    }, 10000)
  }

  loadItinerary() {
    const message = 'Click here to view your itinerary'
    const id = this.data.get('id')
    this.loaderTarget.classList.add('hidden')
    this.messageTarget.classList.remove('hidden')
    this.messageTarget.innerHTML = `<a class="py-4 px-12 bg-teal-500 hover:bg-teal-600 rounded text-white" href="/itineraries/${id}" target="_blank">${message}</a>`
  }
}