<template>
  <div class="weather-container">
    <h2>Météo actuelle</h2>
    <form>
      <input type="text" v-model="researchedCity" placeholder="Entrez le nom d'une ville" />
      <button type="button" @click="submit">Rechercher</button>
    </form>
    <div v-if="weatherData">
      <p>Ville : {{ weatherData.city.name }}</p>
      <p>Température minimum : {{ weatherData.forecast[0].tmin }} °C</p>
      <p>Température maximum : {{ weatherData.forecast[0].tmax }} °C</p>
    </div>
    <div v-else>
      <p>Chargement des données météo...</p>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import axios from 'axios'

export default {
  setup() {
    const researchedCity = ref('')
    const resultResearchedCity = ref('')
    const inseeCode = ref('')
    const weatherData = ref(null)

    const submit = async () => {
      resultResearchedCity.value = researchedCity.value
      console.log(resultResearchedCity.value)
      try {
        const response = await axios.get(
          `https://api.meteo-concept.com/api/location/cities?token=5d1e0b0dc05e9c5451114798e2ba650831b195fcbb3cbd04a211d751da25f3ad&search=${resultResearchedCity.value}`
        )
        console.log(response.data.cities[0].insee)
        inseeCode.value = response.data.cities[0].insee
        await fetchWeather()
        researchedCity.value = ''
      } catch (error) {
        console.log(error)
      }
    }

    const fetchWeather = async () => {
      try {
        const weatherResponse = await axios.get(
          `https://api.meteo-concept.com/api/forecast/daily?token=5d1e0b0dc05e9c5451114798e2ba650831b195fcbb3cbd04a211d751da25f3ad&insee=${inseeCode.value}`
        )
        weatherData.value = weatherResponse.data
      } catch (error) {
        console.log(error)
      }
    }

    return {
      researchedCity,
      inseeCode,
      weatherData,
      submit
    }
  }
}
</script>

<style scoped>
.weather-container {
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 10px;
  text-align: center;
  width: 300px;
  margin: 20px auto;
}

h2 {
  color: #4caf50;
}

p {
  margin: 5px 0;
}
</style>
