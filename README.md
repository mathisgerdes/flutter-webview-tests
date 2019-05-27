# Test 5
Tests: evaluate javascript.

## Expected
The app should show gray background and the text "Hello", as well as a
floating button. If the floating button is pressed, the text
`Response: {"message":"hello"}` should appear.

## On Failure
Try re-installing the app. Maybe the assets added in this step were not
properly synchronized.

Inspect the logs for any javascript errors thrown.

In `lib/main.dart` replace `loadData();` with `alert("hello")`.
Now instead of the text an alert should appear.
If this also doesn't work, there is a problem with forced evaluation of
javascript code.
