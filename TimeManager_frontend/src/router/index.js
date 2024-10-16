import DashboardView from '@/views/DashboardView.vue'
import TeamView from '@/views/TeamView.vue'
import {
  createRouter,
  createWebHistory
} from 'vue-router'
import App from '@/App.vue'
import UserRouteTestView from '@/views/UserRouteTestView.vue'

const router = createRouter({
  history: createWebHistory(
    import.meta.env.BASE_URL),
  routes: [{
    path: '/home',
    component: App
  }, {
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardView
  }, {
    path: '/team', 
    name :'Team',
    component: TeamView
  }, {
    path: '/userRouteTest',
    name: 'UserRouteTest',
    component: UserRouteTestView
  }
  ]
})

export default router