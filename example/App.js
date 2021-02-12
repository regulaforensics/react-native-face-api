import React, { Component } from 'react'
import { StyleSheet, View, Button, Text, Image, TouchableHighlight, Alert } from 'react-native'
import { launchImageLibrary } from 'react-native-image-picker';
import Regula from '@regulaforensics/react-native-face-api-beta'

const Face = Regula.Face
const Enum = Face.Enum
const FaceCaptureResponse = Face.FaceCaptureResponse
const LivenessResponse = Face.LivenessResponse
const MatchFacesResponse = Face.MatchFacesResponse
const MatchFacesRequest = Face.MatchFacesRequest

var image1 = new Face.Image()
var image2 = new Face.Image()

export default class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      resultsActivity: false,
      img1: require('./images/portrait.png'),
      img2: require('./images/portrait.png'),
      similarity: "unknown",
      liveness: "unlnown"
    }
  }

  pickImage(first) {
    Alert.alert("Select option", "", [{
      text: "Use gallery",
      onPress: () => this.useGallery(first)
    },
    {
      text: "Use camera",
      onPress: () => Face.presentFaceCaptureActivity(result => {
        result = FaceCaptureResponse.fromJson(JSON.parse(result))
        if (first) {
          image1.bitmap = result.image.bitmap
          image1.imageType = Enum.eInputFaceType.ift_Live
          this.setState({ img1: { uri: "data:image/png;base64," + image1.bitmap } })
        }
        else {
          image2.bitmap = result.image.bitmap
          image2.imageType = Enum.eInputFaceType.ift_Live
          this.setState({ img2: { uri: "data:image/png;base64," + image2.bitmap } })
        }
      }, e => { })
    }])
  }

  useGallery(first) {
    launchImageLibrary({ includeBase64: true }, response => {
      if (first) {
        this.setState({ img1: { uri: response.uri } })
        image1.bitmap = response.base64
        image1.imageType = Enum.eInputFaceType.ift_DocumentPrinted
      } else {
        this.setState({ img2: { uri: response.uri } })
        image2.bitmap = response.base64
        image2.imageType = Enum.eInputFaceType.ift_DocumentPrinted
      }
    })

  }

  clearResults() {
    this.setState({ img2: require('./images/portrait.png'), img1: require('./images/portrait.png') })
    image1 = null
    image2 = null
  }

  matchFaces() {
    request = new MatchFacesRequest()
    request.images = [image1, image2]
    Face.matchFaces(JSON.stringify(request), response => {
      response = MatchFacesResponse.fromJson(JSON.parse(response))
      matchedFaces = response.matchedFaces
      this.setState({ similarity: matchedFaces.length > 0 ? ((matchedFaces[0].similarity*100).toFixed(2) + "%") : "error" })
    }, e => { this.setState({ similarity: e }) })
  }

  liveness() {
    Face.startLivenessMatching(result => {
      result = LivenessResponse.fromJson(JSON.parse(result))

      image1.bitmap = result.bitmap
      image1.imageType = Enum.eInputFaceType.ift_Live
      this.setState({ img1: { uri: "data:image/png;base64," + image1.bitmap } })
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
