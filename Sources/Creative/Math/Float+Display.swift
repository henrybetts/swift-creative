extension Float {
    /// A user-presentable description, without the `.0` if the number is whole.
    var displayDescription: String {
        let string = description
        return string.hasSuffix(".0") ? String(string.dropLast(2)) : string
    }
}
