package com.reactlibrary;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import com.regula.facesdk.exception.FaceCaptureError;
import com.regula.facesdk.exception.FaceProcessorError;
import com.regula.facesdk.exception.LivenessError;
import com.regula.facesdk.exception.MatchFacesError;
import com.regula.facesdk.params.LivenessParams;
import com.regula.facesdk.results.AgeRange;
import com.regula.facesdk.results.ComparedFace;
import com.regula.facesdk.results.ComparedFacesPair;
import com.regula.facesdk.results.Ethnicity;
import com.regula.facesdk.results.FaceCaptureResponse;
import com.regula.facesdk.results.Gender;
import com.regula.facesdk.results.Landmark;
import com.regula.facesdk.results.LivenessResponse;
import com.regula.facesdk.results.MatchFacesResponse;
import com.regula.facesdk.structs.Image;
import com.regula.facesdk.structs.LivenessRequest;
import com.regula.facesdk.structs.MatchFacesRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@SuppressWarnings({"ConstantConditions", "unused", "RedundantSuppression"})
class JSONConstructor {
    interface JSONObjectGeneratorWithContext<T> {
        JSONObject generateJSONObject(T param, Context context) throws JSONException;
    }

    interface JSONObjectGenerator<T> {
        JSONObject generateJSONObject(T param) throws JSONException;
    }

    interface StringGenerator<T> {
        String generateString(T param);
    }

    static <T> JSONArray generateList(List<T> list) {
        JSONArray result = new JSONArray();
        if(list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(t);

        return result;
    }

    static <T> JSONArray generateList(List<T> list, JSONObjectGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        if(list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(generator.generateJSONObject(t));

        return result;
    }

    static <T> JSONArray generateList(List<T> list, StringGenerator<T> generator) {
        JSONArray result = new JSONArray();
        if(list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(generator.generateString(t));

        return result;
    }

    static <T> JSONArray generateList(List<T> list, JSONObjectGeneratorWithContext<T> generator, Context context) throws JSONException {
        JSONArray result = new JSONArray();
        if(list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(generator.generateJSONObject(t, context));

        return result;
    }

    static <T> JSONArray generateArray(T[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static <T> JSONArray generateArray(T[] array, JSONObjectGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateJSONObject(array[i]));

        return result;
    }

    static <T> JSONArray generateArray(T[] array, StringGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateString(array[i]));

        return result;
    }

    static <T> JSONArray generateArray(T[] array, JSONObjectGeneratorWithContext<T> generator, Context context) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateJSONObject(array[i], context));

        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map) throws JSONException {
        JSONObject result = new JSONObject();
        if(map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), entry.getValue());
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, JSONObjectGenerator<V> generator) throws JSONException {
        JSONObject result = new JSONObject();
        if(map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateJSONObject(entry.getValue()));
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, StringGenerator<V> generator) throws JSONException {
        JSONObject result = new JSONObject();
        if(map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateString(entry.getValue()));
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, JSONObjectGeneratorWithContext<V> generator, Context context) throws JSONException {
        JSONObject result = new JSONObject();
        if(map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateJSONObject(entry.getValue(), context));
        return result;
    }

    static JSONArray generateIntArray(int[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateBooleanArray(boolean[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateDoubleArray(double[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateByteArray(byte[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateLongArray(long[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if(array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static String generateBitmap(Bitmap bitmap) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, byteArrayOutputStream);
        byte[] byteArray = byteArrayOutputStream.toByteArray();

        return Base64.encodeToString(byteArray, Base64.DEFAULT);
    }

    static Bitmap BitmapFromJSON(String base64) {
        byte[] decodedString = Base64.decode(base64, Base64.DEFAULT);
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPreferredConfig = Bitmap.Config.RGB_565;
        Bitmap result = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length, options);
        int sizeMultiplier = result.getByteCount() / 5000000;
        if (result.getByteCount() > 5000000)
            result = Bitmap.createScaledBitmap(result, result.getWidth() / (int) Math.sqrt(sizeMultiplier), result.getHeight() / (int) Math.sqrt(sizeMultiplier), false);
        return result;
    }

    static FaceCaptureError FaceCaptureErrorFromJSON(JSONObject jsonObject) {
        try {
            return new FaceCaptureError(jsonObject.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    static FaceProcessorError FaceProcessorErrorFromJSON(JSONObject jsonObject) {
        try {
            return new FaceProcessorError(jsonObject.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    static LivenessError LivenessErrorFromJSON(JSONObject jsonObject) {
        try {
            return new LivenessError(jsonObject.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    static MatchFacesError MatchFacesErrorFromJSON(JSONObject jsonObject) {
        try {
            return new MatchFacesError(jsonObject.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    // To JSON

    static JSONObject generateFaceCaptureError(FaceCaptureError faceCaptureError) {
        JSONObject result = new JSONObject();
        if (faceCaptureError == null) return result;
        try {
            result.put("errorCode", faceCaptureError.getErrorCode());
            result.put("message", faceCaptureError.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateFaceProcessorError(FaceProcessorError faceProcessorError) {
        JSONObject result = new JSONObject();
        if (faceProcessorError == null) return result;
        try {
            result.put("errorCode", faceProcessorError.getErrorCode());
            result.put("message", faceProcessorError.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessError(LivenessError livenessError) {
        JSONObject result = new JSONObject();
        if (livenessError == null) return result;
        try {
            result.put("errorCode", livenessError.getErrorCode());
            result.put("message", livenessError.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateMatchFacesError(MatchFacesError matchFacesError) {
        JSONObject result = new JSONObject();
        if (matchFacesError == null) return result;
        try {
            result.put("errorCode", matchFacesError.getErrorCode());
            result.put("message", matchFacesError.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessParams(LivenessParams livenessParams) {
        JSONObject result = new JSONObject();
        if (livenessParams == null) return result;
        try {
            result.put("attemptsCount", livenessParams.attemptsCount);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateAgeRange(AgeRange ageRange) {
        JSONObject result = new JSONObject();
        if (ageRange == null) return result;
        try {
            result.put("high", ageRange.high);
            result.put("low", ageRange.low);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateComparedFace(ComparedFace comparedFace) {
        JSONObject result = new JSONObject();
        if (comparedFace == null) return result;
        try {
            result.put("tag", comparedFace.tag);
            result.put("imageType", comparedFace.imageType);
            result.put("position", comparedFace.position);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateComparedFacesPair(ComparedFacesPair comparedFacesPair) {
        JSONObject result = new JSONObject();
        if (comparedFacesPair == null) return result;
        try {
            result.put("first", generateComparedFace(comparedFacesPair.first));
            result.put("second", generateComparedFace(comparedFacesPair.second));
            result.put("similarity", comparedFacesPair.similarity);
            result.put("error", generateMatchFacesError(comparedFacesPair.error));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateEthnicity(Ethnicity ethnicity) {
        JSONObject result = new JSONObject();
        if (ethnicity == null) return result;
        try {
            result.put("confidence", ethnicity.confidence);
            result.put("value", ethnicity.value);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateFaceCaptureResponse(FaceCaptureResponse faceCaptureResponse) {
        JSONObject result = new JSONObject();
        if (faceCaptureResponse == null) return result;
        try {
            result.put("error", generateFaceCaptureError(faceCaptureResponse.error));
            result.put("image", generateImage(faceCaptureResponse.image));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateGender(Gender gender) {
        JSONObject result = new JSONObject();
        if (gender == null) return result;
        try {
            result.put("confidence", gender.confidence);
            result.put("value", gender.value);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLandmark(Landmark landmark) {
        JSONObject result = new JSONObject();
        if (landmark == null) return result;
        try {
            result.put("type", landmark.type);
            result.put("x", landmark.x);
            result.put("y", landmark.y);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessResponse(LivenessResponse livenessResponse) {
        JSONObject result = new JSONObject();
        if (livenessResponse == null) return result;
        try {
            result.put("bitmap", generateBitmap(livenessResponse.getBitmap()));
            result.put("liveness", livenessResponse.liveness);
            result.put("error", generateLivenessError(livenessResponse.error));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateMatchFacesResponse(MatchFacesResponse matchFacesResponse) {
        JSONObject result = new JSONObject();
        if (matchFacesResponse == null) return result;
        try {
            result.put("error", generateFaceProcessorError(matchFacesResponse.error));
            result.put("matchedFaces", generateList(matchFacesResponse.matchedFaces, JSONConstructor::generateComparedFacesPair));
            result.put("unmatchedFaces", generateList(matchFacesResponse.unmatchedFaces, JSONConstructor::generateComparedFacesPair));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateImage(Image image) {
        JSONObject result = new JSONObject();
        if (image == null) return result;
        try {
            result.put("imageType", image.imageType);
            result.put("tag", image.tag);
            result.put("bitmap", generateBitmap(image.getBitmap()));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessRequest(LivenessRequest livenessRequest) {
        JSONObject result = new JSONObject();
        if (livenessRequest == null) return result;
        try {
            result.put("normalImageData", generateByteArray(livenessRequest.normalImageData));
            result.put("scaledImageData", generateByteArray(livenessRequest.scaledImageData));
            result.put("requestBody", generateByteArray(livenessRequest.getRequestBody()));
            result.put("guid", livenessRequest.guid);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateMatchFacesRequest(MatchFacesRequest matchFacesRequest) {
        JSONObject result = new JSONObject();
        if (matchFacesRequest == null) return result;
        try {
            result.put("similarityThreshold", matchFacesRequest.similarityThreshold);
            result.put("images", generateList(matchFacesRequest.images, JSONConstructor::generateImage));
            result.put("customMetadata", matchFacesRequest.customMetadata);
        } catch (JSONException ignored) {
        }
        return result;
    }

    // From JSON

    static LivenessParams LivenessParamsFromJSON(JSONObject jsonObject) {
        LivenessParams result = new LivenessParams();
        try {
            if (jsonObject.has("attemptsCount"))
                result.attemptsCount = jsonObject.getInt("attemptsCount");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static AgeRange AgeRangeFromJSON(JSONObject jsonObject) {
        AgeRange result = new AgeRange();
        try {
            if (jsonObject.has("high"))
                result.high = jsonObject.getInt("high");
            if (jsonObject.has("low"))
                result.low = jsonObject.getInt("low");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static ComparedFace ComparedFaceFromJSON(JSONObject jsonObject) {
        ComparedFace result = new ComparedFace();
        try {
            if (jsonObject.has("tag"))
                result.tag = jsonObject.getString("tag");
            if (jsonObject.has("imageType"))
                result.imageType = jsonObject.getInt("imageType");
            if (jsonObject.has("position"))
                result.position = jsonObject.getInt("position");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static ComparedFacesPair ComparedFacesPairFromJSON(JSONObject jsonObject) {
        ComparedFacesPair result = new ComparedFacesPair();
        try {
            if (jsonObject.has("first"))
                result.first = ComparedFaceFromJSON(jsonObject.getJSONObject("first"));
            if (jsonObject.has("second"))
                result.second = ComparedFaceFromJSON(jsonObject.getJSONObject("second"));
            if (jsonObject.has("similarity"))
                result.similarity = jsonObject.getDouble("similarity");
            if (jsonObject.has("error"))
                result.error = MatchFacesErrorFromJSON(jsonObject.getJSONObject("error"));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Ethnicity EthnicityFromJSON(JSONObject jsonObject) {
        Ethnicity result = new Ethnicity();
        try {
            if (jsonObject.has("confidence"))
                result.confidence = jsonObject.getInt("confidence");
            if (jsonObject.has("value"))
                result.value = jsonObject.getInt("value");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static FaceCaptureResponse FaceCaptureResponseFromJSON(JSONObject jsonObject) {
        FaceCaptureResponse result = new FaceCaptureResponse();
        try {
            if (jsonObject.has("error"))
                result.error = FaceCaptureErrorFromJSON(jsonObject.getJSONObject("error"));
            if (jsonObject.has("image"))
                result.image = ImageFromJSON(jsonObject.getJSONObject("image"));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Gender GenderFromJSON(JSONObject jsonObject) {
        Gender result = new Gender();
        try {
            if (jsonObject.has("confidence"))
                result.confidence = (float) jsonObject.getDouble("confidence");
            if (jsonObject.has("value"))
                result.value = jsonObject.getInt("value");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Landmark LandmarkFromJSON(JSONObject jsonObject) {
        Landmark result = new Landmark();
        try {
            if (jsonObject.has("type"))
                result.type = jsonObject.getInt("type");
            if (jsonObject.has("x"))
                result.x = jsonObject.getInt("x");
            if (jsonObject.has("y"))
                result.y = jsonObject.getInt("y");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static LivenessResponse LivenessResponseFromJSON(JSONObject jsonObject) {
        LivenessResponse result = new LivenessResponse();
        try {
            if (jsonObject.has("liveness"))
                result.liveness = jsonObject.getInt("liveness");
            if (jsonObject.has("error"))
                result.error = LivenessErrorFromJSON(jsonObject.getJSONObject("error"));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static MatchFacesResponse MatchFacesResponseFromJSON(JSONObject jsonObject) {
        MatchFacesResponse result = new MatchFacesResponse();
        try {
            if (jsonObject.has("error"))
                result.error = FaceProcessorErrorFromJSON(jsonObject.getJSONObject("error"));
            if (jsonObject.has("matchedFaces")){
                JSONArray jsonArray = jsonObject.getJSONArray("matchedFaces");
                ArrayList<ComparedFacesPair> array = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++)
                    array.add(ComparedFacesPairFromJSON(jsonArray.getJSONObject(i)));
                result.matchedFaces = array;
            }
            if (jsonObject.has("unmatchedFaces")){
                JSONArray jsonArray = jsonObject.getJSONArray("unmatchedFaces");
                ArrayList<ComparedFacesPair> array = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++)
                    array.add(ComparedFacesPairFromJSON(jsonArray.getJSONObject(i)));
                result.unmatchedFaces = array;
            }
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Image ImageFromJSON(JSONObject jsonObject) {
        Image result = new Image();
        try {
            if (jsonObject.has("imageType"))
                result.imageType = jsonObject.getInt("imageType");
            if (jsonObject.has("tag"))
                result.tag = jsonObject.getString("tag");
            if (jsonObject.has("bitmap"))
                result.setImage(BitmapFromJSON(jsonObject.getString("bitmap")));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static LivenessRequest LivenessRequestFromJSON(JSONObject jsonObject) {
        LivenessRequest result = new LivenessRequest();
        try {
            if (jsonObject.has("normalImageData")){
                JSONArray jsonArray = jsonObject.getJSONArray("normalImageData");
                byte[] array = new byte[jsonArray.length()];
                for (int i = 0; i < jsonArray.length(); i++)
                    array[i] = (byte) jsonArray.get(i);
                result.normalImageData = array;
            }
            if (jsonObject.has("scaledImageData")){
                JSONArray jsonArray = jsonObject.getJSONArray("scaledImageData");
                byte[] array = new byte[jsonArray.length()];
                for (int i = 0; i < jsonArray.length(); i++)
                    array[i] = (byte) jsonArray.get(i);
                result.scaledImageData = array;
            }
            if (jsonObject.has("guid"))
                result.guid = jsonObject.getString("guid");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static MatchFacesRequest MatchFacesRequestFromJSON(JSONObject jsonObject) {
        MatchFacesRequest result = new MatchFacesRequest();
        try {
            if (jsonObject.has("similarityThreshold"))
                result.similarityThreshold = (float) jsonObject.getDouble("similarityThreshold");
            if (jsonObject.has("images")){
                JSONArray jsonArray = jsonObject.getJSONArray("images");
                ArrayList<Image> array = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++)
                    array.add(ImageFromJSON(jsonArray.getJSONObject(i)));
                result.images = array;
            }
            if (jsonObject.has("customMetadata"))
                result.customMetadata = new JSONObject(jsonObject.getString("customMetadata"));
        } catch (JSONException ignored) {
        }
        return result;
    }
}