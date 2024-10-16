<template>
  <div class="flex-1">
    <SidebarComponent :show-sidebar="showSidebar"></SidebarComponent>
    <div class="md:ml-72">
      <HeaderComponent @toggle-sidebar="toggleSidebar"></HeaderComponent>
      <!-- Main content -->
      <RouterView></RouterView>
    </div>
  </div>
</template>

<script>
import { ref, defineComponent } from 'vue'
import SidebarComponent from '@/components/SidebarComponent.vue'
import HeaderComponent from '@/components/HeaderComponent.vue'

export default defineComponent({
  components: { HeaderComponent, SidebarComponent },
  setup() {
    const showSidebar = ref(false)

    const toggleSidebar = () => {
      showSidebar.value = !showSidebar.value
    }

    return {
      showSidebar,
      toggleSidebar
    }
  }
})
</script>

<style>
nav a.router-link-exact-active {
  background-color: #667eea;
}
</style>
