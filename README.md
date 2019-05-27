# Test 2
Tests: local (jaguar) server.

## Expected
The app should show simply the text {"message": "hello"}.

## On Failure
Without closing the app (i.e. only put it into the background), leave it
and open a web browser. In it try opening `localhost:8420/exampleJson`.
If this also does not show the expected text, the jaguar server must
not work properly.
