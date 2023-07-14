import React from 'react'
import { SafeAreaView, StyleSheet, View, Button, Text, Image, TouchableHighlight, Alert, NativeEventEmitter } from 'react-native'
import { launchImageLibrary } from 'react-native-image-picker';
import FaceSDK, { Enum, FaceCaptureResponse, LivenessResponse, MatchFacesResponse, MatchFacesRequest, MatchFacesImage, MatchFacesSimilarityThresholdSplit, RNFaceApi, LivenessNotification, VideoEncoderCompletion } from '@regulaforensics/react-native-face-api'

interface IProps {
}

interface IState {
  img1: any
  img2: any
  similarity: string
  liveness: string
}

var image1 = new MatchFacesImage()
var image2 = new MatchFacesImage()

export default class App extends React.Component<IProps, IState> {
  constructor(props: {} | Readonly<{}>) {
    super(props)

    const eventManager = new NativeEventEmitter(RNFaceApi)
    eventManager.addListener('onCustomButtonTappedEvent', event => console.log(event))
    eventManager.addListener('videoEncoderCompletionEvent', json => {
      var completion = VideoEncoderCompletion.fromJson(JSON.parse(json))!
      console.log("VideoEncoderCompletion:");
      console.log("    success: " + completion.success);
      console.log("    transactionId: " + completion.transactionId);
    })
    eventManager.addListener('livenessNotificationEvent', json => {
      var notification = LivenessNotification.fromJson(JSON.parse(json))!
      console.log("LivenessProcessStatus: " + notification.status);
    })

    FaceSDK.init(json => {
      var response = JSON.parse(json)
      if (!response["success"]) {
        console.log("Init failed: ");
        console.log(json);
      }
    }, _e => { })

    this.state = {
      img1: require('./images/portrait.png'),
      img2: require('./images/portrait.png'),
      similarity: "nil",
      liveness: "nil"
    }
  }

  pickImage(first: boolean) {
    Alert.alert("Select option", "", [
      {
        text: "Use gallery",
        onPress: () => launchImageLibrary({
          mediaType: 'photo',
          selectionLimit: 1,
          includeBase64: true
        }, response => {
          if (response.assets == undefined) return
          this.setImage(first, response.assets[0].base64!, Enum.ImageType.PRINTED)
        })
      },
      {
        text: "Use camera",
        onPress: () => FaceSDK.presentFaceCaptureActivity(json => {
          var response = FaceCaptureResponse.fromJson(JSON.parse(json))!
          if (response.image != null && response.image.bitmap != null)
            this.setImage(first, response.image.bitmap, Enum.ImageType.LIVE)
        }, _e => { })
      }], { cancelable: true })
  }

  setImage(first: boolean, base64: string, type: number) {
    if (base64 == null) return
    this.setState({ similarity: "null" })
    if (first) {
      image1.bitmap = base64
      image1.imageType = type
      this.setState({ img1: { uri: "data:image/png;base64," + base64 } })
      this.setState({ liveness: "null" })
    } else {
      image2.bitmap = base64
      image2.imageType = type
      this.setState({ img2: { uri: "data:image/png;base64," + base64 } })
    }
  }

  clearResults() {
    this.setState({ img1: require('./images/portrait.png') })
    this.setState({ img2: require('./images/portrait.png') })
    this.setState({ similarity: "null" })
    this.setState({ liveness: "null" })
    image1 = new MatchFacesImage()
    image2 = new MatchFacesImage()
  }

  matchFaces() {
    if (image1 == null || image1.bitmap == null || image1.bitmap == "" || image2 == null || image2.bitmap == null || image2.bitmap == "")
      return
    this.setState({ similarity: "Processing..." })
    var request = new MatchFacesRequest()
    request.images = [image1, image2]
    FaceSDK.matchFaces(JSON.stringify(request), json => {
      var response = MatchFacesResponse.fromJson(JSON.parse(json))
      FaceSDK.matchFacesSimilarityThresholdSplit(JSON.stringify(response!.results), 0.75, str => {
        var split = MatchFacesSimilarityThresholdSplit.fromJson(JSON.parse(str))!
        this.setState({ similarity: split.matchedFaces!.length > 0 ? ((split.matchedFaces![0].similarity! * 100).toFixed(2) + "%") : "error" })
      }, e => { this.setState({ similarity: e }) })
    }, e => { this.setState({ similarity: e }) })
  }

  liveness() {
    FaceSDK.startLiveness(json => {
      var response = LivenessResponse.fromJson(JSON.parse(json))!
      if (response.bitmap != null) {
        this.setImage(true, response.bitmap, Enum.ImageType.LIVE)
        this.setState({ liveness: response["liveness"] == Enum.LivenessStatus.PASSED ? "passed" : "unknown" })
      }
    }, _e => { })
  }

  render() {
    return (
      <SafeAreaView style={styles.container}>
        <View style={{ flexDirection: "column", padding: 5 }}>
          <View style={{ flexDirection: "column", alignItems: "center" }}>
            <TouchableHighlight onPress={() => this.pickImage(true)}>
              <Image
                style={{
                  height: 150,
                  width: 150,
                }}
                source={this.state.img1}
                resizeMode="contain" />
            </TouchableHighlight>
          </View>
          <View style={{ flexDirection: "column", alignItems: "center", padding: 5 }}>
            <TouchableHighlight onPress={() => this.pickImage(false)}>
              <Image
                style={{
                  height: 150,
                  width: 200,
                }}
                source={this.state.img2}
                resizeMode="contain" />
            </TouchableHighlight>
          </View>
        </View>

        <View style={{ flexDirection: 'column', width: "100%", alignItems: "center" }}>
          <View style={{ padding: 3, width: "75%" }}>
            <Button color="#4285F4"
              onPress={() => {
                this.matchFaces()
              }}
              title="     Match     "
            />
          </View>
          <View style={{ padding: 3, width: "75%" }}>
            <Button color="#4285F4"
              onPress={() => {
                this.liveness()
              }}
              title="     Liveness     "
            />
          </View>
          <View style={{ padding: 3, width: "75%" }}>
            <Button color="#4285F4"
              onPress={() => {
                this.clearResults()
              }}
              title="Clear"
            />
          </View>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <Text style={{ marginLeft: -20, color: "black" }}>Similarity: {this.state.similarity}</Text>
          <Text style={{ marginLeft: 20, color: "black" }}>Liveness: {this.state.liveness}</Text>
        </View>
      </SafeAreaView>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    width: '100%',
    height: '100%',
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
    marginBottom: 12,
  },
});
