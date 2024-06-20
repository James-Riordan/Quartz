<script lang="ts">
    import { onMount } from 'svelte';
    import { writable } from 'svelte/store';
  
    // Example data structure for your sidebar items
    type SidebarItem = {
      id: number;
      name: string;
      icon: string;
    };
  
    // Store to manage active items
    const activeItem = writable<SidebarItem | null>(null);
  
    // Mock data for sidebar items
    const items: SidebarItem[] = [
      { id: 1, name: 'Notes', icon: '📝' },
      { id: 2, name: 'Tasks', icon: '✅' },
      { id: 3, name: 'Calendar', icon: '📅' },
      { id: 4, name: 'Settings', icon: '⚙️' },
    ];
  
    // Function to set the active item
    function setActiveItem(item: SidebarItem) {
      activeItem.set(item);
    }
  </script>
  
  <style>
    .sidebar {
      width: 250px;
    }
  </style>
  
  <div class="flex flex-col h-full bg-gray-800 text-white sidebar">
    <!-- Top Section -->
    <div class="flex items-center justify-between p-4 bg-gray-900">
      <div class="text-xl font-semibold">Quartz</div>
    </div>
    
    <!-- Search Bar -->
    <div class="p-4">
      <input
        type="text"
        placeholder="Search..."
        class="w-full p-2 rounded bg-gray-700 text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
    </div>
    
    <!-- Sidebar Items -->
    <div class="flex-1 overflow-y-auto">
      {#each items as item}
        <div
          class="flex items-center p-4 cursor-pointer hover:bg-gray-700"
          on:click={() => setActiveItem(item)}
        >
          <span class="mr-3">{item.icon}</span>
          <span>{item.name}</span>
        </div>
      {/each}
    </div>
    
    <!-- Bottom Section -->
    <div class="p-4 bg-gray-900">
      <div class="flex items-center justify-between">
        <span>User</span>
        <button class="p-2 rounded bg-gray-700 hover:bg-gray-600">Logout</button>
      </div>
    </div>
  </div>
  