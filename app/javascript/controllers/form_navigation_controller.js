import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "nextButton", "submitButton"];
  static values = { index: Number };

  connect() {
    this.showCurrentStep();
  }

  next() {
    if (this.indexValue < this.stepTargets.length - 1) {
      this.indexValue++;
    }
    this.showCurrentStep();
  }

  previous() {
    if (this.indexValue > 0) {
      this.indexValue--;
    }
    this.showCurrentStep();
  }

  showCurrentStep() {
    this.stepTargets.forEach((element, index) => {
      element.classList.toggle("hidden", index !== this.indexValue);
    });

    if (this.indexValue === this.stepTargets.length - 1) {
      this.nextButtonTarget.classList.add("hidden");
      this.submitButtonTarget.classList.remove("hidden");
    } else {
      this.nextButtonTarget.classList.remove("hidden");
      this.submitButtonTarget.classList.add("hidden");
    }
  }

  submit() {
    console.log("Form submitted");
  }
}