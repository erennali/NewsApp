# NewsApp

NewsAPI servisini kullanarak dünya genelindeki en son haberleri gösteren modern bir iOS uygulaması.

## 📱 Özellikler

- **Splash Ekranı**: Uygulama logosu ve ismi ile güzel bir başlangıç ekranı
- **Haber Akışı**: Temiz ve modern bir arayüzde en son haberleri görüntüleme
- **Haber Detayları**: Her haber için detaylı bilgileri görüntüleme
- **Ayarlar**: Uygulama ayarlarına erişim (şu anda geliştirme aşamasında)
- **Modern Arayüz**: UIKit kullanılarak iOS tasarım kurallarına uygun olarak geliştirildi
- **Duyarlı Tasarım**: Hem iPhone hem de iPad için optimize edilmiş

## 🛠 Teknik Detaylar

### Mimari
- **MVVM Mimarisi**: Model-View-ViewModel desenini takip eder
- **Protokol Odaklı Programlama**: Daha iyi soyutlama ve test edilebilirlik için protokoller kullanır
- **Bağımlılık Enjeksiyonu**: Servisler daha iyi test edilebilirlik ve bakım için enjekte edilir

### Temel Bileşenler

#### Modeller
- `Article`: Başlık, açıklama, yazar gibi özellikleri içeren haber makalesi
- `NewsModel`: Haber makaleleri dizisini içeren konteyner

#### Görünümler
- `SplashViewController`: Başlangıç yükleme ekranı
- `NewsViewController`: Ana haber akışı görünümü
- `DetailsViewController`: Tek bir haberin detaylı görünümü
- `SettingsViewController`: Uygulama ayarları görünümü (geliştirme aşamasında)
- `NewsCell`: Haber makalelerini görüntülemek için özel UITableViewCell

#### ViewModel'ler
- `NewsViewModel`: Haber akışı verilerini ve iş mantığını yönetir
- `DetailsViewModel`: Haber detay görünümü mantığını yönetir

#### Ağ Katmanı
- `NewsService`: NewsAPI ile iletişimi yönetir
- `NetworkManager`: Genel ağ isteği işleyicisi
- `NetworkError`: Ağ işlemleri için özel hata tipleri

### Bağımlılıklar
- **SnapKit**: Programatik Auto Layout için
- **Kingfisher**: Görsel yükleme ve önbellekleme için
- **NewsAPI**: Haber verileri için harici API

## 🚀 Başlangıç

### Gereksinimler
- Xcode 15.0 veya üzeri
- iOS 17.0 veya üzeri
- Swift 5.0 veya üzeri

### Kurulum
1. Depoyu klonlayın
2. Xcode'da `NewsApp.xcodeproj` dosyasını açın
3. Projeyi derleyin ve çalıştırın

### Yapılandırma
Uygulama haber verilerini çekmek için NewsAPI kullanır. `NetworkConstants.swift` dosyasında geçerli bir API anahtarı olduğundan emin olun.

## 📦 Proje Yapısı

```
NewsApp/
├── App/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── Models/
│   └── NewsModel.swift
├── Network/
│   ├── NewsService.swift
│   ├── NetworkManager.swift
│   ├── NetworkError.swift
│   └── NetworkConstants.swift
├── Scenes/
│   ├── Splash/
│   │   └── SplashViewController.swift
│   ├── News/
│   │   ├── NewsViewController.swift
│   │   ├── NewsViewModel.swift
│   │   └── NewsCell.swift
│   ├── Details/
│   │   ├── DetailsViewController.swift
│   │   └── DetailsViewModel.swift
│   └── Settings/
│       └── SettingsViewController.swift
├── TabBar/
│   └── TabBarController.swift
├── Utilities/
│   └── Extensions/
│       └── UIView.swift
└── Resources/
    └── Base.lproj/
        └── LaunchScreen.storyboard
```

## 🔧 Geliştirme

### Yeni Özellikler Ekleme
1. `Models` dizininde uygun modelleri oluşturun
2. `Scenes` dizininde view model'leri uygulayın
3. İlgili view controller'ları oluşturun
4. Gerekirse `TabBarController`'da navigasyon akışını güncelleyin

### Test
- ViewModel'ler ve Servisler için birim testleri eklenebilir
- View controller'lar için UI testleri uygulanabilir

## 👨‍💻 Yazar

- **Eren Ali Koca** -

## 🙏 Teşekkürler

- Haber verilerini sağlayan NewsAPI'ye
- Mükemmel kütüphaneleri için SnapKit ve Kingfisher ekiplerine 