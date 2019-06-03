# waltz-SDK-example

git clone https://github.com/WaltzApp/waltz-SDK-example

# OAuth

The OAuth flow is based on this architecture.<p align="center">
  <img src="./oauth.png" width="400" title="Architecture OAuth">
</p>

<p>
Waltz implements an authentication system based on the OAuth 2 pattern as per the diagram above. The Waltz SDK handles the display of the login page so that it can intake the credentials as entered by the user, submit them to the Waltz Cloud services and then provide, to the calling mobile app, a token that was returned. To display the login page, consult the plateform specific documentation under its architecture folder (iOS or Android). In the returned token, the app will find information about the user that it can use. It will probably want to send this token to it’s cloud services so that:
<ul>
  <li>the token is confirmed as authentic</li>
  <li>so that the backend can know who is logged into that instance of the app</li>
</ul>
To validate the token, the app’s backend will get a key calling “getSecret” with which it will check the token’s signature. This key can be kept a long time so that token authentications can happen very quickly rather than calling Waltz each time. When this key expires, the backend needs to get a new one (usually once per week).
</p>

GET https://re.waltzlabs.com/mobile/v1/mobileapp/getSecret <p align="center">
  <img src="./endpoint.png" width="800" title="Architecture OAuth">
</p>

This is the expected response: <p align="center">
  <img src="./response.png" width="400" title="Architecture OAuth">
</p>
