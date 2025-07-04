# ModernistYazilim iOS Case

SwiftUI ile geliştirilmiş kullanıcı listesi ve favoriler uygulaması.

## Mimari Seçimi
MVVM pattern kullandım çünkü SwiftUI ile uyumlu ve bu boyutta bir proje için yeterli. ViewModeller ObservableObject protokolünü implement ediyor.

## Öne Çıkan Özellikler
- Kullanıcı arama ve filtreleme
- Favorilere ekleme/çıkarma (SwiftData ile)
- Detay sayfası navigasyonu
- Hata durumları için toast mesajları

## Teknik Kararlar
- Networking: URLSession + async/await + Combine
- State management: @Published properties + ObservableObject
- Navigation: Custom RouterManager (UIKit hybrid)
- Data persistence: SwiftData (modern Core Data)
- Error handling: Protocol-based AppError system

## Geliştirirken Dikkat Ettiğim Noktalar
- **Protocol-oriented programming**: Testability ve flexibility için
- **@MainActor kullanımı**: UI thread safety için
- **Type-safe error handling**: Kullanıcı dostu hata mesajları
- **Clean architecture**: Layer'lar arası dependency injection
- **Modern concurrency**: async/await + Combine reactive patterns

Projeyi çalıştırmak için Xcode 15+ gerekli.