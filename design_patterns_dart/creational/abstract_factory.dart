abstract class Chair {
  void sitOn();
}

class VictorianChair extends Chair {
  void sitOn() {
    print(this.runtimeType);
  }
}

class ModernChair extends Chair {
  void sitOn() {
    print(this.runtimeType);
  }
}

abstract class Sofa {
  void layOn();
}

class VictorianSofa extends Sofa {
  void layOn() {
    print(this.runtimeType);
  }
}

class ModernSofa extends Sofa {
  void layOn() {
    print(this.runtimeType);
  }
}

abstract class Bed {
  void sleepOn();
}

class VictorianBed extends Bed {
  void sleepOn() {
    print(this.runtimeType);
  }
}

class ModernBed extends Bed {
  void sleepOn() {
    print(this.runtimeType);
  }
}

abstract class FurnitureFactory {
  Chair getChair();
  Bed getBed();
  Sofa getSofa();
}

class VictorianFurnitureFactory extends FurnitureFactory {
  getChair() {
    return VictorianChair();
  }

  getBed() {
    return VictorianBed();
  }

  getSofa() {
    return VictorianSofa();
  }
}

class ModernFurnitureFactory extends FurnitureFactory {
  getChair() {
    return ModernChair();
  }

  getBed() {
    return ModernBed();
  }

  getSofa() {
    return ModernSofa();
  }
}

enum FurnitureVariant { victorian, modern }

class FurnitureClient {
  FurnitureFactory _furnitureFactory;
  FurnitureVariant variant;

  FurnitureClient(this.variant)
    : _furnitureFactory = switch (variant) {
        FurnitureVariant.victorian => VictorianFurnitureFactory(),
        FurnitureVariant.modern => ModernFurnitureFactory(),
      };

  FurnitureClient.victorian() : this(FurnitureVariant.victorian);
  FurnitureClient.modern() : this(FurnitureVariant.modern);

  Bed getBed() {
    return _furnitureFactory.getBed();
  }

  Chair getChair() {
    return _furnitureFactory.getChair();
  }

  Sofa getSofa() {
    return _furnitureFactory.getSofa();
  }

  printHouseFurniture() {
    print(getBed());
    print(getSofa());
    print(getChair());
  }
}

void main() {
  FurnitureClient victorianClient = FurnitureClient.victorian();
  victorianClient.printHouseFurniture();

  FurnitureClient modernClient = FurnitureClient.modern();
  modernClient.printHouseFurniture();
}
