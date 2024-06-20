![Tauri x SvelteKit Banner](/banner.png)

# Quartz

Quartz is a high-performance, open-source markdown notes manager designed to be a faster and more efficient alternative to Obsidian. Built with SvelteKit, TailwindCSS, and Tauri, Quartz offers instant opening of files and vaults, providing a seamless and responsive user experience. 

## Features

- **Instant File and Vault Access**: Experience near-instant opening of files and vaults, enhancing your productivity and workflow.
- **High Performance**: Built with SvelteKit and Tauri to ensure a lightweight and fast application, avoiding the bloat of traditional Electron apps.
- **Markdown Support**: Fully integrated markdown support for seamless note-taking and document management.
- **Customizable Interface**: TailwindCSS allows for easy customization and a beautiful, modern interface.
- **Cross-Platform**: Available on all major desktop platforms, including Windows, macOS, and Linux.

## Technology Stack

- **SvelteKit**: A modern framework for building fast, reactive web applications.
- **TailwindCSS**: A utility-first CSS framework for rapid UI development.
- **Tauri**: A framework for building tiny, fast binaries for all major desktop platforms.

## Getting Started

### Prerequisites

- **Node.js**: Ensure you have Node.js installed.
- **Rust and Cargo**: Required by Tauri for building the backend.
- **Tauri CLI**: Install Tauri CLI for development.

### Installation

1. **Clone the repository**:

```shell
   git clone https://github.com/yourusername/quartz.git
   cd quartz
```

2. **Install the packages**

```shell
npm install
```

3.  **Run the Tauri app**

```shell
npm run dev
```

---

### Building the App

a.  **Build for Testing**

```shell
npm run build
```

b. **Build for Production**

```shell
npm run tauri build
```
