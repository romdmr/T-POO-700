<template>
    <div>
        <h1>Test User</h1>
        <button type="button" @click="submit">Rechercher</button>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    setup() {
        const submit = async () => {
            try {
                const response = await axios.get(`http://localhost:4000/api/users`)
                console.log(response.data)
            } catch (error) {
                console.log(error)
            }
        }
        return {
            submit
        }
    }
}
</script>