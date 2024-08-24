class Helper {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@gmail\.com$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid @gmail.com email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include at least one letter, one number, and one special character';
    }
    return null;
  }

  static String getTimeOnly(String timestamp) {
    List<String> parts = timestamp.split(' ');
    if (parts.length > 1) {
      String time = parts[1];
      int dotIndex = time.indexOf('.');
      if (dotIndex != -1) {
        return time.substring(0, dotIndex);
      }
      return time;
    }
    return timestamp; // Return original if format is unexpected
  }

  static String privacyOne =
      "Personal Information: We may collect personal information that you provide directly to us, such as your name, email address, phone number, and payment information when you register an account or make a purchase through the App.";
static String peivacyTwo="Usage Data: We may automatically collect certain information about your device and usage patterns when you access or use the App. This may include your IP address, device type, browser type, operating system, pages visited, and interactions with the App.";
static String apiKey="AIzaSyBbSVNNgp7fA7soa2-52K6hOq67cRhYNzY";

}
