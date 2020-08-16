import { Controller } from "stimulus"
import Turbolinks from "turbolinks"

export default class extends Controller {
  static targets = [  ]

  connect() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
  }
  visit(event) {
    // debugger;
    let id = event.currentTarget.id
    let plot_id = id.match(/plot-([0-9]+)/)[1]

    Turbolinks.visit(`/regions/${plot_id}`);
  }
}
