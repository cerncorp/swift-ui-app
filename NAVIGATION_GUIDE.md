# Navigation to Main Screen Guide

## Current Navigation Flow

Your app currently uses **automatic navigation** based on authentication state:

```
LoginView → RegisterView → MainView (automatic)
```

## 1. Automatic Navigation (Current Implementation)

### How it works:
- `ContentView` monitors `authVM.isLoggedIn`
- When `isLoggedIn = true`, automatically shows `MainView`
- When `isLoggedIn = false`, shows `LoginView`

### Code in ContentView:
```swift
struct ContentView: View {
    @StateObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if authVM.isLoggedIn {
                    MainView()
                        .environmentObject(authVM)
                } else {
                    LoginView()
                        .environmentObject(authVM)
                }
            }
        }
    }
}
```

## 2. Manual Navigation with NavigationLink

### Option A: Direct NavigationLink
```swift
NavigationLink("Go to Main Screen", destination: MainView())
    .environmentObject(authVM)
```

### Option B: Programmatic Navigation
```swift
@State private var navigateToMain = false

NavigationLink("Go to Main", destination: MainView(), isActive: $navigateToMain)
    .environmentObject(authVM)

Button("Navigate") {
    navigateToMain = true
}
```

## 3. Navigation with State Management

### Using @State for Navigation:
```swift
struct LoginView: View {
    @State private var showMainScreen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Your login form
                
                Button("Login") {
                    authVM.login(email: email, password: password)
                    showMainScreen = true
                }
                
                NavigationLink("Go to Main", destination: MainView(), isActive: $showMainScreen)
                    .environmentObject(authVM)
            }
        }
    }
}
```

## 4. Navigation with Custom Navigation Manager

### Create a Navigation Manager:
```swift
class NavigationManager: ObservableObject {
    @Published var currentScreen: Screen = .login
    
    enum Screen {
        case login, register, main
    }
    
    func navigateToMain() {
        currentScreen = .main
    }
    
    func navigateToLogin() {
        currentScreen = .login
    }
}
```

### Use in ContentView:
```swift
struct ContentView: View {
    @StateObject var authVM = AuthViewModel()
    @StateObject var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack {
            Group {
                switch navigationManager.currentScreen {
                case .login:
                    LoginView()
                        .environmentObject(authVM)
                        .environmentObject(navigationManager)
                case .register:
                    RegisterView()
                        .environmentObject(authVM)
                        .environmentObject(navigationManager)
                case .main:
                    MainView()
                        .environmentObject(authVM)
                        .environmentObject(navigationManager)
                }
            }
        }
    }
}
```

## 5. Navigation with TabView

### Create Tab-based Navigation:
```swift
struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(authVM)
    }
}
```

## 6. Navigation with Side Menu

### Create Side Menu Navigation:
```swift
struct SideMenuView: View {
    @Binding var showMenu: Bool
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack {
            Button("Home") {
                // Navigate to home
                showMenu = false
            }
            
            Button("Profile") {
                // Navigate to profile
                showMenu = false
            }
            
            Button("Logout") {
                authVM.logout()
                showMenu = false
            }
        }
        .padding()
    }
}
```

## 7. Current App Navigation Flow

### Your Current Implementation:
1. **App starts** → `ContentView` checks `authVM.isLoggedIn`
2. **If not logged in** → Shows `LoginView`
3. **User clicks "Register"** → Navigates to `RegisterView`
4. **User registers successfully** → `authVM.isLoggedIn = true`
5. **Automatic navigation** → `ContentView` shows `MainView`
6. **User clicks "Logout"** → `authVM.isLoggedIn = false`
7. **Automatic navigation** → `ContentView` shows `LoginView`

## 8. Testing Navigation

### To test current navigation:
1. **Run the app**
2. **Login with any email/password** → Should go to MainView
3. **Click "Logout"** → Should go back to LoginView
4. **Click "Register"** → Should go to RegisterView
5. **Complete registration** → Should go to MainView

## 9. Debugging Navigation

### Add debug prints:
```swift
.onChange(of: authVM.isLoggedIn) { newValue in
    print("🔐 Navigation: isLoggedIn changed to \(newValue)")
}
```

### Check navigation state:
```swift
.onAppear {
    print("📱 Screen appeared: \(type(of: self))")
}
```

## 10. Common Navigation Issues

### Issue: Navigation not working
**Solution:** Check if `authVM.isLoggedIn` is being updated properly

### Issue: RegisterView not dismissing
**Solution:** Use `@Environment(\.dismiss)` to manually dismiss

### Issue: Animation not smooth
**Solution:** Add proper transitions and animations

## Summary

Your app currently uses **automatic navigation** based on authentication state, which is the most common and recommended approach for login/register flows. The navigation happens automatically when `authVM.isLoggedIn` changes.

To manually navigate, you can use `NavigationLink` or programmatic navigation with `@State` variables.
