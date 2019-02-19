# waltz-SDK-example

git clone https://github.com/WaltzApp/waltz-SDK-example

# OAuth

The flow that was build for OAuth is based this architecture. <p align="center">
  <img src="./oauth.png" width="400" title="Architecture OAuth">
</p>

To make the SDK implementation to fetch the JWT see the plateform specific documentation under its architecture folder (iOS or Android). For the backend validation of the secret please use this endpoint as describe here.

GET https://re.waltzlabs.com/mobile/v1/mobileapp/getSecret <p align="center">
  <img src="./endpoint.png" width="800" title="Architecture OAuth">
</p>

And this is the expected response <p align="center">
  <img src="./response.png" width="400" title="Architecture OAuth">
</p>
