# Test 1
Tests: http connection.

## Expected
The http website Detexify should load and be visible full-screen.

## On Failure
In `lib/main.dart` replace the `initial_url` with `https://google.com`.
If this doesn't work either, there is an underlying problem with the webview.
If it does work, there is a problem with http connections.
