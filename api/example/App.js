import React, { Component } from 'react'
import { StyleSheet, View, Button, Text, Image, TouchableHighlight, Alert } from 'react-native'
import { launchImageLibrary } from 'react-native-image-picker';
import FaceSDK, { Enum, FaceCaptureResponse, LivenessResponse, MatchFacesResponse, MatchFacesRequest, Image as FaceImage } from '@regulaforensics/api_module_place_holder'

var image1 = new FaceImage()
var image2 = new FaceImage()

export default class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      img1: require('./images/portrait.png'),
      img2: require('./images/portrait.png'),
      similarity: "nil",
      liveness: "nil"
    }
  }

  pickImage(first) {
    Alert.alert("Select option", "", [
    {
      text: "Use gallery",
      onPress: () => launchImageLibrary({ includeBase64: true }, response => {
        this.setImage(first, response.base64, Enum.ImageType.IMAGE_TYPE_PRINTED)
      })
    },
    {
      text: "Use camera",
      onPress: () => FaceSDK.presentFaceCaptureActivity(result => {
        this.setImage(first, FaceCaptureResponse.fromJson(JSON.parse(result)).image.bitmap, Enum.ImageType.IMAGE_TYPE_LIVE)
      }, e => { })
    }], { cancelable: true })
  }

  setImage(first, base64, type){
    if (base64 == null) return
    this.setState({ similarity: "nil" })
    if (first) {
      image1.bitmap = base64
      image1.imageType = type
      this.setState({ img1: { uri: "data:image/png;base64," + base64 } })
      this.setState({ liveness: "nil" })
    } else {
      image2.bitmap = base64
      image2.imageType = type
      this.setState({ img2: { uri: "data:image/png;base64," + base64 } })
    }
  }

  clearResults() {
    this.setState({ 
      img1: require('./images/portrait.png'), 
      img2: require('./images/portrait.png'),
      similarity: "nil",
      liveness: "nil"
     })
    image1 = new FaceImage()
    image2 = new FaceImage()
  }

  matchFaces() {
    if (image1 == null || image1.bitmap == null || image1.bitmap == "" || image2 == null || image2.bitmap == null || image2.bitmap == "")
      return
    this.setState({ similarity: "Processing..." })
    request = new MatchFacesRequest()
    request.images = [image1, image2]
    FaceSDK.matchFaces(JSON.stringify(request), response => {
      response = MatchFacesResponse.fromJson(JSON.parse(response))
      matchedFaces = response.matchedFaces
      this.setState({ similarity: matchedFaces.length > 0 ? ((matchedFaces[0].similarity * 100).toFixed(2) + "%") : "error" })
    }, e => { this.setState({ similarity: e }) })
  }

  liveness() {
    FaceSDK.startLiveness(result => {
      result = LivenessResponse.fromJson(JSON.parse(result))
      
      this.setImage(true, result.bitmap, Enum.ImageType.IMAGE_TYPE_LIVE)
      if(result.bitmap != null)
        this.setState({ liveness: result["liveness"] == 0 ? "passed" : "unknown" })
    }, e => { })
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.container}>
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
            <Text style={{ marginLeft: -20 }}>Similarity: {this.state.similarity}</Text>
            <Text style={{ marginLeft: 20 }}>Liveness: {this.state.liveness}</Text>
          </View>
        </View>
      </View>
    )
  }
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
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  resultsScreenBackButton: {
    position: 'absolute',
    bottom: 0,
    right: 20
  }
})
