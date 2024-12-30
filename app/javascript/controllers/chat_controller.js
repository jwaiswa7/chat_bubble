import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "container", "input", "messages", "threadId"]

  toggle() {
    this.containerTarget.classList.toggle("hidden")
  }

  handleSubmit(event){
    this.inputTarget.value = "";
    this.inputTarget.disabled = true;
  }

}