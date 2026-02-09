# 🎰GaCha!
**GaCha**는 메이플스토리의 클래식한 디자인과 경제 시스템을 모티브로 한 아이템 상점 및 확률형 뽑기 시뮬레이션 iOS 앱입니다.

## 🧾 프로젝트 소개
**GaCha!** 프로젝트는 **iOS UIKit** 기반으로 메이플스토리 감성의 아이템 샵과 뽑기 시스템을 설계·구현하며고급 레이아웃 구성, 효율적인 데이터 구조, 객체 간 통신을 학습하기 위해 제작된 프로젝트입니다.
- **IdentifiedCollections 기반 통합 데이터 관리**: 인벤토리 내 중복 아이템 합산 및 수정 시 `$O(1)$` 성능 확보
- **Compositional Layout 중심 UI 구성**: 단일 `CollectionView` 내 멀티 섹션(Paging, Button, List) 구현
- **Protocol-Oriented Communication**: 다양한 `Delegate` 패턴 적용으로 객체 간 결합도 최소화
- **SnapKit 기반의 정교한 UI 설계**: 레이아웃 및 등급별 동적 테마 적용

## ✨ 핵심 기능 (Key Features)
- **1. 하이브리드 상점 시스템**
    - **멀티 카테고리 지원**: 무기, 상의, 하의, 모자, 신발 등 5가지 카테고리의 아이템 데이터를 분류하여 제공합니다.
    - **일반 아이템 구매**: 상점 리스트에서 일반 등급 아이템을 다중 선택하여 보유한 '메소'로 즉시 구매할 수 있습니다.

- **2. 고도화된 가챠(뽑기) 시스템**
    - **확률형 아이템 획득**: **지정된 확률** 로 강력한 레전더리 아이템을 획득할 수 있는 뽑기 로직을 구현했습니다.
    - **연속 뽑기 기능**: 1회 및 5회 연속 뽑기 기능을 지원하며, 결과는 즉시 인벤토리에 반영됩니다.
    - **실시간 결과 트래킹**: 가챠 결과 섹션을 통해 최근 획득한 아이템 5개를 실시간으로 확인할 수 있습니다.

- **3. 스마트 인벤토리 및 경제 시스템**
    - **자동 스택 관리**: 동일 아이템 획득 시 인벤토리 내 수량이 자동으로 합산되어 효율적인 관리가 가능합니다.
    - **아이템 판매 및 환급**: 보유 아이템을 개별 혹은 전체 판매할 수 있으며, 판매 시 원가에 **지정된 감가**를 적용하여 메소로 환급받습니다.
    - **실시간 재화 동기화**: `DataManager`의 재화 상태 변화를 감지하여 메인 화면의 메소 잔액 UI를 즉각적으로 갱신합니다.

- **4. 등급별 동적 테마 UI**
    - **시각적 희귀도 강조**: 아이템 등급(일반, 레전더리)에 따라 셀의 배경색과 텍스트 컬러가 자동으로 반전되어 획득의 재미를 시각화했습니다.
    - **정밀한 레이아웃**: `SnapKit`을 활용해 테이블 뷰와 헤더 간의 컬럼 너비를 정밀하게 일치시켜 가독성 높은 정보를 제공합니다.

## 📁 프로젝트 구조
```
GaCha 
├── Controller 
│   ├── InventoryViewController.swift 
│   └── ViewController.swift 
├── Helper 
│   ├── FormatterManager.swift 
│   ├── GachaCategory.swift 
│   └── Identifier.swift 
├── Model 
│   ├── DataManager.swift 
│   ├── Item.swift 
│   ├── Meso.swift 
│   └── PurchaseItem.swift 
├── Protocol 
│   ├── CategorySegmentedControlDelegate.swift 
│   ├── InventoryItemCellDelegate.swift 
│   ├── InventoryViewControllerDelegate.swift 
│   ├── InventoryViewDelegate.swift 
│   └── MainViewDelegate.swift 
├── View 
│   ├── GachaViewComp 
│   │   ├── GachaButtonCell.swift 
│   │   ├── GachaCollectionFooterView.swift 
│   │   ├── GachaCollectionHeaderView.swift 
│   │   ├── GachaResultCell.swift 
│   │   ├── LegendaryItemCell.swift 
│   │   └── MesoBadgeView.swift 
│   ├── InventoryViewComp 
│   │   ├── InventoryHeaderView.swift 
│   │   ├── InventoryItemCell.swift 
│   │   ├── InventoryTableView.swift 
│   │   └── InventoryView.swift 
│   ├── ItemViewComp 
│   │   ├── ItemCell.swift 
│   │   └── ItemTableView.swift 
│   ├── ActionButton.swift 
│   ├── CategorySegmentedControl.swift 
│   ├── GachaCollectionView.swift 
│   ├── MainView.swift 
│   └── MesoStackView.swift 
└── Resources 
    ├── AppDelegate.swift 
    ├── SceneDelegate.swift 
    ├── Assets.xcassets 
    └── Info.plist
```

## 📁 구조 설명
### Controller
- **ViewController.swift**: `종합 시스템 관리`
- **InventoryViewController.swift**: `Inventory Modal 시스템 관리`

### Model
- **DataManager.swift**: `Singleton Pattern`, `Meso`, `inventoryList` 통합 관리

### View
- **GachaViewComp**
    - **...Cell**: 각 `Section`에 필요한 `Custom Cell` 정의
    - **...View**: `Section` 주변의 부가적인 View (`Header`, `Footer`, `Badge`)
- **InventoryViewComp, ItemViewComp**
    - **...Cell**: 각 TableView의 `Custom Cell`
    - **...View**: `UI` 정의
- **MainView(디렉토리에 포함되지 않은 파일)**: MainView 내부 `UI` 정의

## 🛠 Tech Stack
- **Language**: `Swift`
- **UI Framework**: `UIKit`
- **Layout**: `SnapKit`
- **Design Pattern**: `MVC, Delegate, Singleton`
