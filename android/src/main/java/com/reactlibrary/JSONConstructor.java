package com.reactlibrary;

import static com.reactlibrary.UtilsKt.*;

import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.util.Size;

import com.regula.facesdk.detection.request.DetectFacesConfiguration;
import com.regula.facesdk.detection.request.DetectFacesRequest;
import com.regula.facesdk.detection.request.ImageQualityCharacteristic;
import com.regula.facesdk.detection.request.ImageQualityGroup;
import com.regula.facesdk.detection.request.ImageQualityRange;
import com.regula.facesdk.detection.request.OutputImageCrop;
import com.regula.facesdk.detection.request.OutputImageParams;
import com.regula.facesdk.detection.response.DetectFaceResult;
import com.regula.facesdk.detection.response.DetectFacesAttributeResult;
import com.regula.facesdk.detection.response.DetectFacesResponse;
import com.regula.facesdk.detection.response.ImageQualityResult;
import com.regula.facesdk.enums.*;
import com.regula.facesdk.exception.DetectFacesBackendException;
import com.regula.facesdk.exception.DetectFacesErrorException;
import com.regula.facesdk.exception.FaceCaptureException;
import com.regula.facesdk.exception.InitException;
import com.regula.facesdk.exception.LivenessBackendException;
import com.regula.facesdk.exception.LivenessErrorException;
import com.regula.facesdk.exception.MatchFacesException;
import com.regula.facesdk.model.Image;
import com.regula.facesdk.model.LivenessNotification;
import com.regula.facesdk.model.MatchFacesImage;
import com.regula.facesdk.model.results.FaceCaptureResponse;
import com.regula.facesdk.model.results.LivenessResponse;
import com.regula.facesdk.model.results.matchfaces.MatchFacesComparedFace;
import com.regula.facesdk.model.results.matchfaces.MatchFacesComparedFacesPair;
import com.regula.facesdk.model.results.matchfaces.MatchFacesDetection;
import com.regula.facesdk.model.results.matchfaces.MatchFacesDetectionFace;
import com.regula.facesdk.model.results.matchfaces.MatchFacesResponse;
import com.regula.facesdk.model.results.matchfaces.MatchFacesSimilarityThresholdSplit;
import com.regula.facesdk.model.results.personDb.Person;
import com.regula.facesdk.model.results.personDb.PersonGroup;
import com.regula.facesdk.model.results.personDb.PersonImage;
import com.regula.facesdk.model.results.personDb.SearchPerson;
import com.regula.facesdk.model.results.personDb.SearchPersonImage;
import com.regula.facesdk.request.MatchFacesRequest;
import com.regula.facesdk.request.personDb.EditGroupPersonsRequest;
import com.regula.facesdk.request.personDb.ImageUpload;
import com.regula.facesdk.request.personDb.SearchPersonRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@SuppressWarnings({"UnnecessaryLocalVariable", "UnusedAssignment", "ConstantConditions", "EnhancedSwitchMigration", "RedundantSuppression"})
class JSONConstructor {
    static JSONObject generateByteArrayImage(byte[] input) {
        if (input == null) return null;
        JSONObject result = new JSONObject();
        try {
            result.put("image", generateByteArray(input));
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    static JSONObject generateVideoEncoderCompletion(String transactionId, boolean success) {
        JSONObject result = new JSONObject();
        try {
            result.put("transactionId", transactionId);
            result.put("success", success);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateInitCompletion(boolean success, InitException error) {
        JSONObject result = new JSONObject();
        try {
            result.put("error", generateInitException(error));
            result.put("success", success);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateSearchPersonDetection(SearchPerson.Detection input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("landmarks", generateList(input.getLandmarks(), JSONConstructor::generatePoint));
            result.put("rect", generateRect(input.getRect()));
            result.put("cropImage", input.getCropImage());
            result.put("rotationAngle", input.getRotationAngle());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static DetectFacesAttribute stringToDetectFacesAttribute(String input) {
        for (DetectFacesAttribute iterator : DetectFacesAttribute.values())
            if (iterator.getValue().equals(input))
                return iterator;
        return null;
    }

    static OutputImageParams OutputImageParamsFromJSON(JSONObject input) {
        try {
            int backgroundColor = 0;
            if (input.has("backgroundColor")) {
                backgroundColor = Color.parseColor(input.getString("backgroundColor"));
            }
            OutputImageCrop imageCropParams = null;
            if (input.has("crop")) {
                imageCropParams = OutputImageCropFromJSON(input.getJSONObject("crop"));
            }
            OutputImageParams result = new OutputImageParams(imageCropParams, backgroundColor);
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static LivenessSkipStep[] LivenessSkipStepArrayFromJSON(JSONArray input) throws JSONException {
        LivenessSkipStep[] result = new LivenessSkipStep[input.length()];
        for (int i = 0; i < input.length(); i++)
            switch (input.getInt(i)) {
                case 1:
                    result[i] = LivenessSkipStep.ONBOARDING_STEP;
                    break;
                case 2:
                    result[i] = LivenessSkipStep.SUCCESS_STEP;
                    break;
            }
        return result;
    }

    static OutputImageCrop OutputImageCropFromJSON(JSONObject input) {
        try {
            OutputImageCropAspectRatio type = null;
            if (input.has("type")) {
                int type_input = input.getInt("type");
                OutputImageCropAspectRatio[] type_array = OutputImageCropAspectRatio.values();
                for (OutputImageCropAspectRatio iterator : type_array)
                    if (iterator.getValue() == type_input)
                        type = iterator;
            } else return null;
            Size size = null;
            if (input.has("size")) {
                size = SizeFromJSON(input.getJSONObject("size"));
            } else return new OutputImageCrop(type);
            int padColor = 0;
            if (input.has("padColor")) {
                padColor = Color.parseColor(input.getString("padColor"));
            } else return new OutputImageCrop(type, size);
            boolean returnOriginalRect = false;
            if (input.has("returnOriginalRect")) {
                returnOriginalRect = input.getBoolean("returnOriginalRect");
            } else return new OutputImageCrop(type, size, padColor);
            return new OutputImageCrop(type, size, padColor, returnOriginalRect);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static List<ImageQualityCharacteristic> ImageQualityCharacteristicFromJSON(JSONObject input) {
        try {
            ImageQualityCharacteristic result = ImageQualityGroup.ImageCharacteristic.paddingRatio(0, 0.5);
            if (!input.has("characteristicName")) return null;
            String name = input.getString("characteristicName");

            double min = 0;
            double max = 0;
            if (input.has("range")) {
                min = input.getJSONArray("range").getDouble(0);
                max = input.getJSONArray("range").getDouble(1);
            }

            switch (name) {
                case "ImageWidth":
                    if (input.has("range"))
                        result = ImageQualityGroup.ImageCharacteristic.imageWidthWithRange(min, max);
                    else return null;
                    break;
                case "ImageHeight":
                    if (input.has("range"))
                        result = ImageQualityGroup.ImageCharacteristic.imageHeightWithRange(min, max);
                    else return null;
                    break;
                case "ImageWidthToHeight":
                    if (input.has("range"))
                        result = ImageQualityGroup.ImageCharacteristic.imageWidthToHeightWithRange(min, max);
                    else return null;
                    break;
                case "ImageChannelsNumber":
                    if (input.has("imageChannelsNumber"))
                        result = ImageQualityGroup.ImageCharacteristic.imageChannelsNumberWithValue(input.getDouble("imageChannelsNumber"));
                    else return null;
                    break;
                case "PaddingRatio":
                    result = ImageQualityGroup.ImageCharacteristic.paddingRatio(min, max);
                    break;
                case "ArtFace":
                    result = ImageQualityGroup.ImageCharacteristic.artFace();
                    break;
                case "ImageCharacteristic":
                    return ImageQualityGroup.ImageCharacteristic.allRecommended();

                case "FaceMidPointHorizontalPosition":
                    result = ImageQualityGroup.HeadSizeAndPosition.faceMidPointHorizontalPosition();
                    break;
                case "FaceMidPointVerticalPosition":
                    result = ImageQualityGroup.HeadSizeAndPosition.faceMidPointVerticalPosition();
                    break;
                case "HeadWidthRatio":
                    result = ImageQualityGroup.HeadSizeAndPosition.headWidthRatio();
                    break;
                case "HeadHeightRatio":
                    result = ImageQualityGroup.HeadSizeAndPosition.headHeightRatio();
                    break;
                case "EyesDistance":
                    result = ImageQualityGroup.HeadSizeAndPosition.eyesDistance();
                    break;
                case "Yaw":
                    result = ImageQualityGroup.HeadSizeAndPosition.yaw();
                    break;
                case "Pitch":
                    result = ImageQualityGroup.HeadSizeAndPosition.pitch();
                    break;
                case "Roll":
                    result = ImageQualityGroup.HeadSizeAndPosition.roll();
                    break;
                case "HeadSizeAndPosition":
                    return ImageQualityGroup.HeadSizeAndPosition.allRecommended();

                case "BlurLevel":
                    result = ImageQualityGroup.FaceImageQuality.blurLevel();
                    break;
                case "NoiseLevel":
                    result = ImageQualityGroup.FaceImageQuality.noiseLevel();
                    break;
                case "UnnaturalSkinTone":
                    result = ImageQualityGroup.FaceImageQuality.unnaturalSkinTone();
                    break;
                case "FaceDynamicRange":
                    result = ImageQualityGroup.FaceImageQuality.faceDynamicRange();
                    break;
                case "FaceImageQuality":
                    return ImageQualityGroup.FaceImageQuality.allRecommended();

                case "EyeRightClosed":
                    result = ImageQualityGroup.EyesCharacteristics.eyeRightClosed();
                    break;
                case "EyeLeftClosed":
                    result = ImageQualityGroup.EyesCharacteristics.eyeLeftClosed();
                    break;
                case "EyeRightOccluded":
                    result = ImageQualityGroup.EyesCharacteristics.eyeRightOccluded();
                    break;
                case "EyeLeftOccluded":
                    result = ImageQualityGroup.EyesCharacteristics.eyeLeftOccluded();
                    break;
                case "EyesRed":
                    result = ImageQualityGroup.EyesCharacteristics.eyesRed();
                    break;
                case "EyeRightCoveredWithHair":
                    result = ImageQualityGroup.EyesCharacteristics.eyeRightCoveredWithHair();
                    break;
                case "EyeLeftCoveredWithHair":
                    result = ImageQualityGroup.EyesCharacteristics.eyeLeftCoveredWithHair();
                    break;
                case "OffGaze":
                    result = ImageQualityGroup.EyesCharacteristics.offGaze();
                    break;
                case "EyesCharacteristics":
                    return ImageQualityGroup.EyesCharacteristics.allRecommended();

                case "TooDark":
                    result = ImageQualityGroup.ShadowsAndLightning.tooDark();
                    break;
                case "TooLight":
                    result = ImageQualityGroup.ShadowsAndLightning.tooLight();
                    break;
                case "FaceGlare":
                    result = ImageQualityGroup.ShadowsAndLightning.faceGlare();
                    break;
                case "ShadowsOnFace":
                    result = ImageQualityGroup.ShadowsAndLightning.shadowsOnFace();
                    break;
                case "ShadowsAndLightning":
                    return ImageQualityGroup.ShadowsAndLightning.allRecommended();

                case "ShouldersPose":
                    result = ImageQualityGroup.PoseAndExpression.shouldersPose();
                    break;
                case "ExpressionLevel":
                    result = ImageQualityGroup.PoseAndExpression.expressionLevel();
                    break;
                case "MouthOpen":
                    result = ImageQualityGroup.PoseAndExpression.mouthOpen();
                    break;
                case "Smile":
                    result = ImageQualityGroup.PoseAndExpression.smile();
                    break;
                case "PoseAndExpression":
                    return ImageQualityGroup.PoseAndExpression.allRecommended();

                case "DarkGlasses":
                    result = ImageQualityGroup.HeadOcclusion.darkGlasses();
                    break;
                case "ReflectionOnGlasses":
                    result = ImageQualityGroup.HeadOcclusion.reflectionOnGlasses();
                    break;
                case "FramesTooHeavy":
                    result = ImageQualityGroup.HeadOcclusion.framesTooHeavy();
                    break;
                case "FaceOccluded":
                    result = ImageQualityGroup.HeadOcclusion.faceOccluded();
                    break;
                case "HeadCovering":
                    result = ImageQualityGroup.HeadOcclusion.headCovering();
                    break;
                case "ForeheadCovering":
                    result = ImageQualityGroup.HeadOcclusion.foreheadCovering();
                    break;
                case "StrongMakeup":
                    result = ImageQualityGroup.HeadOcclusion.strongMakeup();
                    break;
                case "Headphones":
                    result = ImageQualityGroup.HeadOcclusion.headphones();
                    break;
                case "MedicalMask":
                    result = ImageQualityGroup.HeadOcclusion.medicalMask();
                    break;
                case "HeadOcclusion":
                    return ImageQualityGroup.HeadOcclusion.allRecommended();

                case "BackgroundUniformity":
                    result = ImageQualityGroup.QualityBackground.backgroundUniformity();
                    break;
                case "ShadowsOnBackground":
                    result = ImageQualityGroup.QualityBackground.shadowsOnBackground();
                    break;
                case "OtherFaces":
                    result = ImageQualityGroup.QualityBackground.otherFaces();
                    break;
                case "BackgroundColorMatch":
                    if (input.has("color"))
                        result = ImageQualityGroup.QualityBackground.backgroundColorMatchWithColor(Color.parseColor(input.getString("color")));
                    else
                        result = ImageQualityGroup.QualityBackground.backgroundColorMatch();
                    break;
                case "QualityBackground":
                    return ImageQualityGroup.QualityBackground.allRecommended();

                default:
                    return null;
            }

            if (input.has("customRange")) {
                min = input.getJSONArray("customRange").getDouble(0);
                max = input.getJSONArray("customRange").getDouble(1);
                return Collections.singletonList(result.withCustomRange(min, max));
            }
            return Collections.singletonList(result);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static DetectFacesConfiguration DetectFacesConfigurationFromJSON(JSONObject input) {
        try {
            DetectFacesConfiguration result = new DetectFacesConfiguration();
            List<DetectFacesAttribute> attributes = new ArrayList<>();
            if (input.has("attributes")) {
                JSONArray jsonArray_attributes = input.getJSONArray("attributes");
                for (int i = 0; i < jsonArray_attributes.length(); i++)
                    attributes.add(stringToDetectFacesAttribute(jsonArray_attributes.getString(i)));
                result.setAttributes(attributes);
            }
            List<ImageQualityCharacteristic> customQuality = new ArrayList<>();
            if (input.has("customQuality")) {
                JSONArray jsonArray_customQuality = input.getJSONArray("customQuality");
                for (int i = 0; i < jsonArray_customQuality.length(); i++)
                    customQuality.addAll(ImageQualityCharacteristicFromJSON(jsonArray_customQuality.getJSONObject(i)));
                result.setCustomQuality(customQuality);
            }
            OutputImageParams outputImageParams = null;
            if (input.has("outputImageParams")) {
                outputImageParams = OutputImageParamsFromJSON(input.getJSONObject("outputImageParams"));
                result.setOutputImageParams(outputImageParams);
            }
            boolean onlyCentralFace = false;
            if (input.has("onlyCentralFace")) {
                onlyCentralFace = input.getBoolean("onlyCentralFace");
                result.setOnlyCentralFace(onlyCentralFace);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static DetectFacesRequest DetectFacesRequestFromJSON(JSONObject input) {
        final String CROP_CENTRAL_FACE = "CropCentralFace";
        final String CROP_ALL_FACES = "CropAllFaces";
        final String THUMBNAIL = "Thumbnail";
        final String ATTRIBUTES_ALL = "AttributesAll";
        final String QUALITY_FULL = "QualityFull";
        final String QUALITY_ICAO = "QualityICAO";
        final String QUALITY_VISA_SCHENGEN = "QualityVisaSchengen";
        final String QUALITY_VISA_USA = "QualityVisaUSA";
        try {
            if (!input.has("image"))
                return null;
            Bitmap image = BitmapFromJSON(input.getString("image"));
            if (input.has("scenario")) {
                String scenario = input.getString("scenario");
                switch (scenario) {
                    case CROP_CENTRAL_FACE:
                        return DetectFacesRequest.cropCentralFaceRequestForImage(image);
                    case CROP_ALL_FACES:
                        return DetectFacesRequest.cropAllFacesRequestForImage(image);
                    case THUMBNAIL:
                        return DetectFacesRequest.thumbnailRequestForImage(image);
                    case ATTRIBUTES_ALL:
                        return DetectFacesRequest.allAttributesRequestForImage(image);
                    case QUALITY_FULL:
                        return DetectFacesRequest.qualityFullRequestForImage(image);
                    case QUALITY_ICAO:
                        return DetectFacesRequest.qualityICAORequestForImage(image);
                    case QUALITY_VISA_SCHENGEN:
                        return DetectFacesRequest.qualityVisaSchengenRequestForImage(image);
                    case QUALITY_VISA_USA:
                        return DetectFacesRequest.qualityVisaUSARequestForImage(image);
                }
            }
            if (!input.has("configuration"))
                return null;
            String tag = null;
            if (input.has("tag"))
                tag = input.getString("tag");

            DetectFacesConfiguration configuration = DetectFacesConfigurationFromJSON(input.getJSONObject("configuration"));
            return new DetectFacesRequest(image, configuration, tag);
        } catch (JSONException ignored) {
        }
        return null;
    }

    static MatchFacesComparedFacesPair MatchFacesComparedFacesPairFromJSON(JSONObject input) {
        try {
            MatchFacesComparedFace first = null;
            if (input.has("first") && !input.isNull("first")) {
                first = MatchFacesComparedFaceFromJSON(input.getJSONObject("first"));
            }
            MatchFacesComparedFace second = null;
            if (input.has("second") && !input.isNull("second")) {
                second = MatchFacesComparedFaceFromJSON(input.getJSONObject("second"));
            }
            float similarity = 0;
            if (input.has("similarity") && !input.isNull("similarity")) {
                similarity = (float) input.getDouble("similarity");
            }
            float score = 0;
            if (input.has("score") && !input.isNull("score")) {
                score = (float) input.getDouble("score");
            }
            MatchFacesException exception = null;
            if (input.has("exception") && !input.isNull("exception")) {
                exception = MatchFacesExceptionFromJSON(input.getJSONObject("exception"));
            }
            MatchFacesComparedFacesPair result = (new MatchFacesComparedFacesPair.a()).a(first, second, exception, similarity, score).a();
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesDetectionFace MatchFacesDetectionFaceFromJSON(JSONObject input) {
        try {
            int faceIndex = 0;
            if (input.has("faceIndex") && !input.isNull("faceIndex")) {
                faceIndex = input.getInt("faceIndex");
            }
            List<Point> landmarks = new ArrayList<>();
            if (input.has("landmarks") && !input.isNull("landmarks")) {
                JSONArray jsonArray_landmarks = input.getJSONArray("landmarks");
                for (int i = 0; i < jsonArray_landmarks.length(); i++)
                    landmarks.add(PointFromJSON(jsonArray_landmarks.getJSONObject(i)));
            }
            Rect faceRect = null;
            if (input.has("faceRect") && !input.isNull("faceRect")) {
                faceRect = RectFromJSON(input.getJSONObject("faceRect"));
            }
            double rotationAngle = 0;
            if (input.has("rotationAngle") && !input.isNull("rotationAngle")) {
                rotationAngle = input.getDouble("rotationAngle");
            }
            MatchFacesDetectionFace result = (new MatchFacesDetectionFace.a()).a(faceIndex, rotationAngle, landmarks, faceRect).a();
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesComparedFace MatchFacesComparedFaceFromJSON(JSONObject input) {
        try {
            MatchFacesDetectionFace face = null;
            if (input.has("face") && !input.isNull("face")) {
                face = MatchFacesDetectionFaceFromJSON(input.getJSONObject("face"));
            }
            MatchFacesImage image = null;
            if (input.has("image") && !input.isNull("image")) {
                image = MatchFacesImageFromJSON(input.getJSONObject("image"));
            }
            int faceIndex = 0;
            if (input.has("faceIndex") && !input.isNull("faceIndex")) {
                faceIndex = input.getInt("faceIndex");
            }
            int imageIndex = 0;
            if (input.has("imageIndex") && !input.isNull("imageIndex")) {
                imageIndex = input.getInt("imageIndex");
            }
            MatchFacesComparedFace result = (new MatchFacesComparedFace.a()).a(imageIndex, image, faceIndex, face).a();
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Typeface typeFaceFromJSON(JSONObject input) {
        String name = input.optString("name", "");
        int style = input.optInt("style", Typeface.NORMAL);
        return Typeface.create(name, style);
    }

    static String idFromJSON(JSONObject input){
        try {
            return input.getString("id");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Person updatePersonFromJSON(Person result, JSONObject input) {
        try {
            String name = null;
            if (input.has("name") && !input.isNull("name")) {
                name = input.getString("name");
                result.setName(name);
            }
            JSONObject metadata = null;
            if (input.has("metadata") && !input.isNull("metadata")) {
                metadata = input.getJSONObject("metadata");
                result.setMetaData(metadata);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static PersonGroup updatePersonGroupFromJSON(PersonGroup result, JSONObject input) {
        try {
            String name = null;
            if (input.has("name") && !input.isNull("name")) {
                name = input.getString("name");
                result.setName(name);
            }
            JSONObject metadata = null;
            if (input.has("metadata") && !input.isNull("metadata")) {
                metadata = input.getJSONObject("metadata");
                result.setMetaData(metadata);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    // To JSON

    static JSONObject generateFaceCaptureException(FaceCaptureException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().toString());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateInitException(InitException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().toString());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateLivenessErrorException(LivenessErrorException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().toString());
            result.put("underlyingException", generateLivenessBackendException(input.getUnderlyingException()));
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateLivenessBackendException(LivenessBackendException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().getValue());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesException(MatchFacesException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().toString());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateFaceCaptureResponse(FaceCaptureResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("exception", generateFaceCaptureException(input.getException()));
            result.put("image", generateImage(input.getImage()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateLivenessResponse(LivenessResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("bitmap", generateBitmap(input.getBitmap()));
            result.put("liveness", input.getLiveness() == null ? input.getLiveness() : input.getLiveness().toString());
            result.put("tag", input.getTag());
            result.put("transactionId", input.getTransactionId());
            result.put("estimatedAge", input.getEstimatedAge());
            result.put("exception", generateLivenessErrorException(input.getException()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesResponse(MatchFacesResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("tag", input.getTag());
            result.put("exception", generateMatchFacesException(input.getException()));
            result.put("detections", generateList(input.getDetections(), JSONConstructor::generateMatchFacesDetection));
            result.put("results", generateList(input.getResults(), JSONConstructor::generateMatchFacesComparedFacesPair));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateImage(Image input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("imageType", input.getImageType() == null ? input.getImageType() : input.getImageType().getValue());
            result.put("bitmap", generateBitmap(input.getBitmap()));
            result.put("tag", input.getTag());
            result.put("imageData", generateByteArray(input.getImageData()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesImage(MatchFacesImage input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("imageType", input.getImageType() == null ? input.getImageType() : input.getImageType().getValue());
            result.put("detectAll", input.isDetectAll());
            result.put("bitmap", generateBitmap(input.getBitmap()));
            result.put("identifier", input.getIdentifier());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesComparedFacesPair(MatchFacesComparedFacesPair input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("first", generateMatchFacesComparedFace(input.getFirst()));
            result.put("second", generateMatchFacesComparedFace(input.getSecond()));
            result.put("similarity", input.getSimilarity());
            result.put("score", input.getScore());
            result.put("exception", generateMatchFacesException(input.getException()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesComparedFace(MatchFacesComparedFace input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("face", generateMatchFacesDetectionFace(input.getDetectionFace()));
            result.put("image", generateMatchFacesImage(input.getMatchesFaceImage()));
            result.put("faceIndex", input.getFaceIndex());
            result.put("imageIndex", input.getImageIndex());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesDetectionFace(MatchFacesDetectionFace input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("faceIndex", input.getFaceIndex());
            result.put("landmarks", generateList(input.getLandmarks(), JSONConstructor::generatePoint));
            result.put("faceRect", generateRect(input.getFaceRect()));
            result.put("rotationAngle", input.getRotationAngle());
            result.put("thumbnail", generateBitmap(input.getThumbnail()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesDetection(MatchFacesDetection input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("image", generateMatchFacesImage(input.getImage()));
            result.put("imageIndex", input.getImageIndex());
            result.put("faces", generateList(input.getFaces(), JSONConstructor::generateMatchFacesDetectionFace));
            result.put("exception", generateMatchFacesException(input.getException()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generatePoint(Point input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("x", input.x);
            result.put("y", input.y);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateRect(Rect input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("bottom", input.bottom);
            result.put("top", input.top);
            result.put("left", input.left);
            result.put("right", input.right);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesSimilarityThresholdSplit(MatchFacesSimilarityThresholdSplit input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("matchedFaces", generateList(input.getMatchedFaces(), JSONConstructor::generateMatchFacesComparedFacesPair));
            result.put("unmatchedFaces", generateList(input.getUnmatchedFaces(), JSONConstructor::generateMatchFacesComparedFacesPair));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateImageQualityRange(ImageQualityRange input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("min", input.getMin());
            result.put("max", input.getMax());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateDetectFacesResponse(DetectFacesResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("detection", generateDetectFaceResult(input.getDetection()));
            result.put("scenario", input.getScenario());
            result.put("error", generateDetectFacesErrorException(input.getError()));
            result.put("allDetections", generateList(input.getAllDetections(), JSONConstructor::generateDetectFaceResult));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateDetectFacesErrorException(DetectFacesErrorException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().toString());
            result.put("underlyingException", generateDetectFacesBackendException(input.getUnderlyingException()));
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateDetectFacesBackendException(DetectFacesBackendException input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("errorCode", input.getErrorCode() == null ? input.getErrorCode() : input.getErrorCode().getValue());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateDetectFaceResult(DetectFaceResult input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("quality", generateList(input.getQuality(), JSONConstructor::generateImageQualityResult));
            result.put("attributes", generateList(input.getAttributes(), JSONConstructor::generateDetectFacesAttributeResult));
            result.put("landmarks", generateList(input.getLandMarks(), JSONConstructor::generatePoint));
            result.put("crop", input.getCropImage());
            result.put("faceRect", generateRect(input.getFaceRect()));
            result.put("originalRect", generateRect(input.getOriginalRect()));
            result.put("isQualityCompliant", input.isQualityCompliant());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateImageQualityResult(ImageQualityResult input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("name", input.getName() == null ? input.getName() : input.getName().getValue());
            result.put("group", input.getGroup() == null ? input.getGroup() : input.getGroup().getValue());
            result.put("status", input.getStatus() == null ? input.getStatus() : input.getStatus().getValue());
            result.put("range", generateImageQualityRange(input.getRange()));
            result.put("value", input.getValue());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateDetectFacesAttributeResult(DetectFacesAttributeResult input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("attribute", input.getAttribute() == null ? input.getAttribute() : input.getAttribute().getValue());
            result.put("value", input.getValue());
            result.put("range", generateImageQualityRange(input.getRange()));
            result.put("confidence", input.getConfidence());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generatePerson(Person input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("name", input.getName());
            result.put("groups", generateArray(input.getGroups()));
            result.put("updatedAt", input.getUpdatedAt().toString());
            result.put("id", input.getId());
            result.put("metadata", input.getMetadata());
            result.put("createdAt", input.getCreatedAt().toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generatePersonGroup(PersonGroup input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("name", input.getName());
            result.put("id", input.getId());
            result.put("metadata", input.getMetadata());
            result.put("createdAt", input.getCreatedAt().toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generatePersonImage(PersonImage input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("path", input.getPath());
            result.put("url", input.getUrl());
            result.put("contentType", input.getContentType());
            result.put("id", input.getId());
            result.put("metadata", input.getMetadata());
            result.put("createdAt", input.getCreatedAt().toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateSearchPerson(SearchPerson input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("detection", generateSearchPersonDetection(input.getDetection()));
            result.put("images", generateList(input.getImages(), JSONConstructor::generateSearchPersonImage));
            result.put("name", input.getName());
            result.put("groups", generateArray(input.getGroups()));
            result.put("updatedAt", input.getUpdatedAt().toString());
            result.put("id", input.getId());
            result.put("metadata", input.getMetadata());
            result.put("createdAt", input.getCreatedAt().toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateSearchPersonImage(SearchPersonImage input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("similarity", input.getSimilarity());
            result.put("distance", input.getDistance());
            result.put("path", input.getPath());
            result.put("url", input.getUrl());
            result.put("contentType", input.getContentType());
            result.put("id", input.getId());
            result.put("metadata", input.getMetadata());
            result.put("createdAt", input.getCreatedAt().toString());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateLivenessNotification(LivenessNotification input) {
        JSONObject result = new JSONObject();
        if (input == null) return null;
        try {
            result.put("status", input.getStatus() == null ? input.getStatus() : input.getStatus().toString());
            result.put("response", generateLivenessResponse(input.getResponse()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    // From JSON

    static MatchFacesException MatchFacesExceptionFromJSON(JSONObject input) {
        try {
            MatchFacesErrorCode errorCode = null;
            if (input.has("errorCode") && !input.isNull("errorCode")) {
                errorCode = MatchFacesErrorCode.valueOf(input.getString("errorCode"));
            }
            MatchFacesException result = new MatchFacesException(errorCode);
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesRequest MatchFacesRequestFromJSON(JSONObject input) {
        try {
            List<MatchFacesImage> images = new ArrayList<>();
            if (input.has("images") && !input.isNull("images")) {
                JSONArray jsonArray_images = input.getJSONArray("images");
                for (int i = 0; i < jsonArray_images.length(); i++)
                    images.add(MatchFacesImageFromJSON(jsonArray_images.getJSONObject(i)));
            }
            MatchFacesRequest result = new MatchFacesRequest(images);
            JSONObject customMetadata = null;
            if (input.has("customMetadata") && !input.isNull("customMetadata")) {
                customMetadata = new JSONObject(input.getString("customMetadata"));
                result.setCustomMetadata(customMetadata);
            }
            boolean thumbnails = false;
            if (input.has("thumbnails") && !input.isNull("thumbnails")) {
                thumbnails = input.getBoolean("thumbnails");
                result.setThumbnails(thumbnails);
            }
            String tag = null;
            if (input.has("tag") && !input.isNull("tag")) {
                tag = input.getString("tag");
                result.setTag(tag);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesImage MatchFacesImageFromJSON(JSONObject input) {
        try {
            ImageType imageType = null;
            if (input.has("imageType") && !input.isNull("imageType")) {
                int imageType_input = input.getInt("imageType");
                ImageType[] imageType_array = ImageType.values();
                for (ImageType iterator: imageType_array)
                    if (iterator.getValue() == imageType_input)
                        imageType = iterator;
            }
            boolean detectAll = false;
            if (input.has("detectAll") && !input.isNull("detectAll")) {
                detectAll = input.getBoolean("detectAll");
            }
            Bitmap bitmap = null;
            if (input.has("bitmap") && !input.isNull("bitmap")) {
                bitmap = BitmapFromJSON(input.getString("bitmap"));
            }
            MatchFacesImage result = new MatchFacesImage(bitmap, imageType, detectAll);
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Point PointFromJSON(JSONObject input) {
        try {
            Point result = new Point();
            int x = 0;
            if (input.has("x") && !input.isNull("x")) {
                x = input.getInt("x");
                result.x = x;
            }
            int y = 0;
            if (input.has("y") && !input.isNull("y")) {
                y = input.getInt("y");
                result.y = y;
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Rect RectFromJSON(JSONObject input) {
        try {
            Rect result = new Rect();
            int bottom = 0;
            if (input.has("bottom") && !input.isNull("bottom")) {
                bottom = input.getInt("bottom");
                result.bottom = bottom;
            }
            int top = 0;
            if (input.has("top") && !input.isNull("top")) {
                top = input.getInt("top");
                result.top = top;
            }
            int left = 0;
            if (input.has("left") && !input.isNull("left")) {
                left = input.getInt("left");
                result.left = left;
            }
            int right = 0;
            if (input.has("right") && !input.isNull("right")) {
                right = input.getInt("right");
                result.right = right;
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Size SizeFromJSON(JSONObject input) {
        try {
            int width = 0;
            if (input.has("width") && !input.isNull("width")) {
                width = input.getInt("width");
            }
            int height = 0;
            if (input.has("height") && !input.isNull("height")) {
                height = input.getInt("height");
            }
            Size result = new Size(width, height);
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static ImageUpload ImageUploadFromJSON(JSONObject input) {
        try {
            ImageUpload result = new ImageUpload();
            byte[] imageData = null;
            if (input.has("imageData") && !input.isNull("imageData")) {
                imageData = ByteArrayFromJSON(input.getString("imageData"));
                result.setImageData(imageData);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static EditGroupPersonsRequest EditGroupPersonsRequestFromJSON(JSONObject input) {
        try {
            EditGroupPersonsRequest result = new EditGroupPersonsRequest();
            String[] personIdsToAdd = new String[0];
            if (input.has("personIdsToAdd") && !input.isNull("personIdsToAdd")) {
                JSONArray jsonArray_personIdsToAdd = input.getJSONArray("personIdsToAdd");
            personIdsToAdd = new String[jsonArray_personIdsToAdd.length()];
                for (int i = 0; i < jsonArray_personIdsToAdd.length(); i++)
                    personIdsToAdd[i] = jsonArray_personIdsToAdd.getString(i);
                result.setPersonIdsToAdd(personIdsToAdd);
            }
            String[] personIdsToRemove = new String[0];
            if (input.has("personIdsToRemove") && !input.isNull("personIdsToRemove")) {
                JSONArray jsonArray_personIdsToRemove = input.getJSONArray("personIdsToRemove");
            personIdsToRemove = new String[jsonArray_personIdsToRemove.length()];
                for (int i = 0; i < jsonArray_personIdsToRemove.length(); i++)
                    personIdsToRemove[i] = jsonArray_personIdsToRemove.getString(i);
                result.setPersonIdsToRemove(personIdsToRemove);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static SearchPersonRequest SearchPersonRequestFromJSON(JSONObject input) {
        try {
            SearchPersonRequest result = new SearchPersonRequest();
            OutputImageParams outputImageParams = null;
            if (input.has("outputImageParams") && !input.isNull("outputImageParams")) {
                outputImageParams = OutputImageParamsFromJSON(input.getJSONObject("outputImageParams"));
                result.setOutputImageParams(outputImageParams);
            }
            String[] groupIdsForSearch = new String[0];
            if (input.has("groupIdsForSearch") && !input.isNull("groupIdsForSearch")) {
                JSONArray jsonArray_groupIdsForSearch = input.getJSONArray("groupIdsForSearch");
            groupIdsForSearch = new String[jsonArray_groupIdsForSearch.length()];
                for (int i = 0; i < jsonArray_groupIdsForSearch.length(); i++)
                    groupIdsForSearch[i] = jsonArray_groupIdsForSearch.getString(i);
                result.setGroupIdsForSearch(groupIdsForSearch);
            }
            float threshold = 0;
            if (input.has("threshold") && !input.isNull("threshold")) {
                threshold = (float) input.getDouble("threshold");
                result.setThreshold(threshold);
            }
            int limit = 0;
            if (input.has("limit") && !input.isNull("limit")) {
                limit = input.getInt("limit");
                result.setLimit(limit);
            }
            ImageUpload imageUpload = null;
            if (input.has("imageUpload") && !input.isNull("imageUpload")) {
                imageUpload = ImageUploadFromJSON(input.getJSONObject("imageUpload"));
                result.setImageUpload(imageUpload);
            }
            boolean detectAll = false;
            if (input.has("detectAll") && !input.isNull("detectAll")) {
                detectAll = input.getBoolean("detectAll");
                result.setDetectAll(detectAll);
            }
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}