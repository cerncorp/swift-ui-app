Ok, mình sẽ làm lại **project SwiftUI** với flow:

**Login** → **Register** → **Main Screen**,
kèm điều hướng và quản lý trạng thái đăng nhập.

---

## 1. Cấu trúc

* `ContentView` → màn hình root, kiểm tra trạng thái đăng nhập.
* `LoginView` → màn hình đăng nhập.
* `RegisterView` → màn hình đăng ký.
* `MainView` → màn hình chính.
* `AuthViewModel` → quản lý trạng thái đăng nhập (logic + state).

---

## 2. Code SwiftUI

**AuthViewModel.swift**

```swift
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    
    func login(email: String, password: String) {
        // Giả sử login thành công
        self.email = email
        self.isLoggedIn = true
    }
    
    func register(email: String, password: String) {
        // Giả sử đăng ký thành công
        self.email = email
        self.isLoggedIn = true
    }
    
    func logout() {
        self.email = ""
        self.isLoggedIn = false
    }
}
```

---

**ContentView\.swift**

```swift
import SwiftUI

struct ContentView: View {
    @StateObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
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
```

---

**LoginView\.swift**

```swift
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Login") {
                authVM.login(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty)
            
            NavigationLink("Register", destination: RegisterView())
        }
        .padding()
    }
}
```

---

**RegisterView\.swift**

```swift
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            Button("Create Account") {
                if password == confirmPassword {
                    authVM.register(email: email, password: password)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
        }
        .padding()
    }
}
```

---

**MainView\.swift**

```swift
import SwiftUI

struct MainView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome, \(authVM.email)")
                .font(.title)
            
            Button("Logout") {
                authVM.logout()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
```

---

**MyApp.swift**

```swift
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

---

## 3. Điểm nổi bật

* **@EnvironmentObject** giúp truyền trạng thái đăng nhập giữa các màn hình.
* **NavigationStack** điều hướng login → register → main.
* **AuthViewModel** chứa toàn bộ logic login/register/logout.
* Bạn có thể dễ dàng thay login giả lập bằng API thật.

---

Nếu muốn, mình có thể **bổ sung lưu trạng thái đăng nhập vào UserDefaults** để khi mở lại app không cần login lại.
Bạn có muốn mình thêm tính năng đó luôn không?
