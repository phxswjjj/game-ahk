class MyMap Extends Map {
    Extends(map) {
        For mapKey, mapValue In map
            this.Set(mapKey, mapValue)
    }
}