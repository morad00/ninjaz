# Keep classes with specific annotations
-keep @interface com.ninjaz.ae.ninjaz.annotations.Keep

# Keep classes in specific packages
-keep class com.ninjaz.ae.ninjaz.model.** { *; }

# Keep specific classes and their methods
-keep class com.ninjaz.ae.ninjaz.MainActivity {
    public void onCreate(android.os.Bundle);
}

# Keep all Parcelable implementation classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
