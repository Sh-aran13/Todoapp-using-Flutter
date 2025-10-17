# Project Blueprint

## Overview

This is a to-do list application that allows users to create, view, edit, and delete tasks. The application features a theme provider for light/dark mode switching and uses `go_router` for navigation.

## Features

*   **Task Management:** Create, edit, delete, and toggle the status of tasks.
*   **Theme Provider:** Manages the application's theme, allowing users to switch between light and dark modes.
*   **Custom Fonts:** Uses Google Fonts to style the text.
*   **Routing:** Uses the `go_router` package for navigation between the task list and task detail screens.
*   **State Management:** Uses the `provider` package to manage the state of the tasks.
*   **Firebase:** Configured with Firebase for Android, iOS, and Web.
*   **Authentication:** Basic email/password authentication with redirection.

## Plan

*   Restructure the application to link all providers, screens, and widgets in `main.dart`.
*   Implement routing and navigation using `go_router`, with redirects based on authentication state.
*   Remove the old `lib/router.dart` file.
