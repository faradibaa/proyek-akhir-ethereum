import { createApp } from 'vue'
import App from './App.vue'

/* import the fontawesome core */
import { library } from '@fortawesome/fontawesome-svg-core'

/* import font awesome icon component */
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

/* import specific icons */
import { faWallet } from '@fortawesome/free-solid-svg-icons'

/* Import bootstrap-vue */
// import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
// Import Bootstrap and BootstrapVue CSS files (order is important)
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"

/* add icons to the library */
library.add(faWallet)

// Make BootstrapVue available throughout your project
// createApp(App).use(BootstrapVue)
// // Optionally install the BootstrapVue icon components plugin
// createApp(App).use(IconsPlugin)

createApp(App)
.component('font-awesome-icon', FontAwesomeIcon)
// .component('bootstrap-vue', BootstrapVue)
// .component('bootstrap-vue-icons-plugin', IconsPlugin)
.mount('#app')
