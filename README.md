# QuoteFlow 🌸

QuoteFlow is a premium, beautifully crafted Flutter application designed to inspire and motivate you with a curated repository of wisdom from history's greatest minds. It brings focus, clarity, and perspective to your daily life through a minimal, high-aesthetic interface.

---

## ✨ Features

- 🌀 **Ambient Mesh Background:** Smoothly shifting, radiant gradient colors that create a peaceful, premium atmosphere.
- 🔀 **Smart Randomization:** Smart randomizer that picks fresh quotes without consecutive repetitions.
- 🎨 **Premium Animations:** Custom slide and fade transitions for quotes and splash screens using native animation frameworks.
- 🌓 **Responsive Dark Mode:** Seamless integration with system dark/light theme preferences.
- 💻 **GitHub Navigation:** A dedicated About Screen with details about the app features and direct repository linking support.

---

## 🛠️ Technology Stack

- **Framework:** [Flutter](https://flutter.dev) (SDK version `^3.7.0`)
- **Language:** [Dart](https://dart.dev)
- **Dependencies:**
  - `cupertino_icons` (for native iOS style iconography)
  - `url_launcher` (for external web page links and navigation)

---

## 🚀 Getting Started

To run QuoteFlow locally on your machine, follow these instructions:

### Prerequisites

Make sure you have the [Flutter SDK installed](https://docs.flutter.dev/get-started/install) and configured on your system.

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Md-Arif-Ul-Islam/QuoteFlow.git
   cd Code_Alpha
   ```

2. **Get Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the Application:**
   ```bash
   flutter run
   ```

### Running Tests

Run the widget and unit test suites to verify application stability:
```bash
flutter test
```

---

## 📂 Project Structure

```
lib/
├── data/
│   └── quotes.dart             # Curated wisdom and quote dataset
├── screens/
│   ├── about_screen.dart       # About page & external links
│   ├── home_screen.dart        # Core quote presentation UI
│   └── splash_screen.dart      # Opening brand intro and animations
├── widgets/
│   ├── animated_background.dart # Shifting ambient mesh gradient
│   └── quote_card.dart         # Glassmorphic card for quote rendering
└── main.dart                   # Application entrypoint & Theme config
```
