<template>
  <div class="container mx-auto p-4">

    <!-- Create User Form -->
    <div class="mb-6 p-4 border border-gray-300 rounded-md">
      <h2 class="text-lg font-semibold mb-2">Create User</h2>
      <form @submit.prevent="submitForm" class="space-y-2">
        <div>
          <label for="firstname" class="block">First Name:</label>
          <input type="text" id="firstname" v-model="firstname" class="border border-gray-300 rounded-md p-2 w-full"
            required>
        </div>
        <div>
          <label for="lastname" class="block">Last Name:</label>
          <input type="text" id="lastname" v-model="lastname" class="border border-gray-300 rounded-md p-2 w-full"
            required>
        </div>
        <div>
          <label for="email" class="block">Email:</label>
          <input type="email" id="email" v-model="email" class="border border-gray-300 rounded-md p-2 w-full" required>
        </div>
        <div>
          <label for="password" class="block">Password:</label>
          <input type="password" id="password" v-model="password" class="border border-gray-300 rounded-md p-2 w-full"
            required>
        </div>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md">Create User</button>
      </form>
      <!-- Result message -->
      <div v-if="createResult" class="mt-4 text-green-500">
        {{ createResult }}
      </div>
    </div>

    <!-- Read Users -->
    <div class="mb-6 p-4 border border-gray-300 rounded-md">
      <h2 class="text-lg font-semibold mb-2">Users List</h2>
      <button @click="fetchUsers" class="bg-green-500 text-white px-4 py-2 rounded-md">Fetch Users</button>
      <ul v-if="users.length > 0" class="mt-4 space-y-1">
        <li v-for="user in users" :key="user.id" class="border border-gray-200 p-2 rounded-md">
          {{ user.username }} ({{ user.email }}) - ID: {{ user.id }}
        </li>
      </ul>
      <!-- Error or empty message -->
      <div v-else class="mt-4 text-red-500">
        {{fetchError}}
      </div>
    </div>

    <!-- Search User Form -->
    <div class="mb-6 p-4 border border-gray-300 rounded-md">
      <h2 class="text-lg font-semibold mb-2">Search user by ID</h2>
      <form @submit.prevent="getUserById" class="space-y-2">
        <div>
          <label for="research-id" class="block">User ID:</label>
          <input type="number" id="research-id" v-model="searchId" class="border border-gray-300 rounded-md p-2 w-full"
            required>
        </div>
        <button type="submit" class="bg-orange-500 text-white px-4 py-2 rounded-md">Search user by id</button>
      </form>
      <!-- Result message -->
      <div v-if="researchResult" class="mt-4 text-green-500">
        <p>Nom : {{researchedUser.lastname}}</p>
        <p>Prénom : {{researchedUser.firstname}}</p>
      </div>
    </div>

    <!-- Update User Form -->
    <div class="mb-6 p-4 border border-gray-300 rounded-md">
      <h2 class="text-lg font-semibold mb-2">Update User</h2>
      <form @submit.prevent="updateUser" class="space-y-2">
        <div>
          <label for="update-id" class="block">User ID:</label>
          <input type="number" id="update-id" v-model="updateId" class="border border-gray-300 rounded-md p-2 w-full"
            required>
        </div>
        <div>
          <label for="update-firstname" class="block">First Name:</label>
          <input type="text" id="update-firstname" v-model="updateFirstname" class="border border-gray-300 rounded-md p-2 w-full"
                 required>
        </div>
        <div>
          <label for="update-lastname" class="block">Last Name:</label>
          <input type="text" id="update-lastname" v-model="updateLastname" class="border border-gray-300 rounded-md p-2 w-full"
                 required>
        </div>
        <div>
          <label for="update-email" class="block">New Email:</label>
          <input type="email" id="update-email" v-model="updateEmail"
            class="border border-gray-300 rounded-md p-2 w-full" required>
        </div>
        <button type="submit" class="bg-yellow-500 text-white px-4 py-2 rounded-md">Update User</button>
      </form>
      <!-- Result message -->
      <div v-if="updateResult" class="mt-4 text-green-500">
        {{ updateResult }}
      </div>
    </div>

    <!-- Delete User Form -->
    <div class="mb-6 p-4 border border-gray-300 rounded-md">
      <h2 class="text-lg font-semibold mb-2">Delete User</h2>
      <form @submit.prevent="deleteUser" class="space-y-2">
        <div>
          <label for="delete-id" class="block">User ID:</label>
          <input type="number" id="delete-id" v-model="deleteId" class="border border-gray-300 rounded-md p-2 w-full"
            required>
        </div>
        <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded-md">Delete User</button>
      </form>
      <!-- Result message -->
      <div v-if="deleteResult" class="mt-4 text-green-500">
        {{ deleteResult }}
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import axios from "axios";

export default {
  setup() {
    const firstname = ref("");
    const lastname = ref("");
    const email = ref("");
    const password = ref("");
    const users = ref([]);
    const updateId = ref(null);
    const updateFirstname = ref("");
    const updateLastname = ref("");
    const updateEmail = ref("");
    const deleteId = ref(null);
    const searchId = ref(null);
    const createResult = ref("");
    const updateResult = ref("");
    const deleteResult = ref("");
    const researchResult = ref("");
    const fetchError = ref("");
    const researchedUser = ref(null);

    const submitForm = async () => {
      try {
        const response = await axios.post('http://localhost:4000/api/users', {
          user: {
            firstname: firstname.value,
            lastname: lastname.value,
            email: email.value,
            password: password.value
          }
        });
        if (response.status === 201) {
          createResult.value = "User successfully created!";
        }
      } catch (error) {
        createResult.value = "Error creating user.";
        console.log(error);
      }
    };

    const fetchUsers = async () => {
      try {
        const response = await axios.get('http://localhost:4000/api/users');
        if (response.data && Array.isArray(response.data.data)) {
          users.value = response.data.data;
          fetchError.value = "";
        } else {
          fetchError.value = "No users found.";
        }
      } catch (error) {
        fetchError.value = "Error fetching users.";
        console.log(error);
      }
    };

    const getUserById = async () => {
      researchedUser.value = null;
      researchResult.value = null;
      try {
        const response = await axios.get(`http://localhost:4000/api/users/${searchId.value}`);
        if (response.status === 200) {
          researchResult.value = "User find";
          researchedUser.value = response.data.data
        } else if (response.status !== 200){
          researchResult.value = "No user find"
        }
      } catch (error) {
        researchResult.value = "Error researching user.";
        console.log(error);
      }
    };

    const updateUser = async () => {
      try {
        const response = await axios.put(`http://localhost:4000/api/users/${updateId.value}`, {
          user: {
            email: updateEmail.value,
            firstname: updateFirstname.value,
            lastname: updateLastname.value,
          }
        });
        if (response.status === 201) {
          updateResult.value = "User successfully updated!";
          await fetchUsers(); // Refresh user list after update
        }
      } catch (error) {
        updateResult.value = "Error updating user.";
        console.log(error);
      }
    };

    const deleteUser = async () => {
      try {
        const response = await axios.delete(`http://localhost:4000/api/users/${deleteId.value}`);
        if (response.status === 204) {
          deleteResult.value = "User successfully deleted!";
          await fetchUsers(); // Refresh user list after deletion
        }
      } catch (error) {
        deleteResult.value = "Error deleting user.";
        console.log(error);
      }
    };

    return {
      firstname,
      lastname,
      email,
      password,
      users,
      updateId,
      updateFirstname,
      updateLastname,
      updateEmail,
      deleteId,
      searchId,
      createResult,
      updateResult,
      deleteResult,
      researchResult,
      fetchError,
      researchedUser,
      submitForm,
      fetchUsers,
      updateUser,
      deleteUser,
      getUserById
    };
  }
};
</script>
