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
import com.regula.facesdk.results.FaceDetail;
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
        for (T t : list)
            if (t != null)
                result.put(t);

        return result;
    }

    static <T> JSONArray generateList(List<T> list, JSONObjectGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        for (T t : list)
            if (t != null)
                result.put(generator.generateJSONObject(t));

        return result;
    }

    static <T> JSONArray generateList(List<T> list, StringGenerator<T> generator) {
        JSONArray result = new JSONArray();
        for (T t : list)
            if (t != null)
                result.put(generator.generateString(t));

        return result;
    }

    static <T> JSONArray generateList(List<T> list, JSONObjectGeneratorWithContext<T> generator, Context context) throws JSONException {
        JSONArray result = new JSONArray();
        for (T t : list)
            if (t != null)
                result.put(generator.generateJSONObject(t, context));

        return result;
    }

    static <T> JSONArray generateArray(T[] array) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static <T> JSONArray generateArray(T[] array, JSONObjectGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateJSONObject(array[i]));

        return result;
    }

    static <T> JSONArray generateArray(T[] array, StringGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateString(array[i]));

        return result;
    }

    static <T> JSONArray generateArray(T[] array, JSONObjectGeneratorWithContext<T> generator, Context context) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateJSONObject(array[i], context));

        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map) throws JSONException {
        JSONObject result = new JSONObject();
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), entry.getValue());
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, JSONObjectGenerator<V> generator) throws JSONException {
        JSONObject result = new JSONObject();
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateJSONObject(entry.getValue()));
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, StringGenerator<V> generator) throws JSONException {
        JSONObject result = new JSONObject();
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateString(entry.getValue()));
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, JSONObjectGeneratorWithContext<V> generator, Context context) throws JSONException {
        JSONObject result = new JSONObject();
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateJSONObject(entry.getValue(), context));
        return result;
    }

    static JSONArray generateIntArray(int[] array) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateBooleanArray(boolean[] array) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateDoubleArray(double[] array) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateByteArray(byte[] array) throws JSONException {
        JSONArray result = new JSONArray();
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateLongArray(long[] array) throws JSONException {
        JSONArray result = new JSONArray();
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

//    static JSONObject generateBoundingBox(BoundingBox boundingBox) {
//        JSONObject result = new JSONObject();
//        if (boundingBox == null) return result;
//        try {
//            result.put("left", boundingBox.left);
//            result.put("top", boundingBox.top);
//            result.put("height", boundingBox.height);
//            result.put("width", boundingBox.width);
//        } catch (JSONException ignored) {
//        }
//
//        return result;
//    }

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
            result.put("capturedImage", generateImage(faceCaptureResponse.capturedImage));
        } catch (JSONException ignored) {
        }

        return result;
    }

    static JSONObject generateFaceDetail(FaceDetail faceDetail) {
        JSONObject result = new JSONObject();
        if (faceDetail == null) return result;
        try {
            result.put("ageRange", generateAgeRange(faceDetail.ageRange));
//            result.put("boundingBox", generateBoundingBox(faceDetail.boundingBox));
            result.put("gender", generateGender(faceDetail.gender));
            result.put("landmarks", generateList(faceDetail.landmarks, JSONConstructor::generateLandmark));
            result.put("ethnicity", generateList(faceDetail.ethnicity, JSONConstructor::generateEthnicity));
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
            result.put("bitmaps", generateArray(livenessResponse.bitmaps, JSONConstructor::generateBitmap));
            result.put("faceIndex", livenessResponse.faceIndex);
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

    static MatchFacesRequest MatchFacesRequestFromJson(JSONObject jsonObject) {
        MatchFacesRequest result = new MatchFacesRequest();
        try {
            if (jsonObject.has("similarityThreshold"))
                result.similarityThreshold = (float) jsonObject.getDouble("similarityThreshold");
            if (jsonObject.has("customMetadata"))
                result.customMetadata = new JSONObject(jsonObject.getString("customMetadata"));
            if (jsonObject.has("images")) {
                result.images = new ArrayList<>();
                JSONArray jsonArray = jsonObject.getJSONArray("images");
                for (int i = 0; i < jsonArray.length(); i++)
                    result.images.add(ImageFromJson(jsonArray.getJSONObject(i)));
            }
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Image ImageFromJson(JSONObject jsonObject) {
        Image result = new Image();
        try {
            if (jsonObject.has("imageType"))
                result.imageType = jsonObject.getInt("imageType");
            if (jsonObject.has("tag"))
                result.tag = jsonObject.getString("tag");
            if (jsonObject.has("bitmap"))
                result.setImage(bitmapFromBase64(jsonObject.getString("bitmap")));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Bitmap bitmapFromBase64(String base64) {
        byte[] decodedString = Base64.decode(base64, Base64.DEFAULT);
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPreferredConfig = Bitmap.Config.RGB_565;
        Bitmap result = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length, options);
        int sizeMultiplier = result.getByteCount() / 5000000;
        if (result.getByteCount() > 5000000)
            result = Bitmap.createScaledBitmap(result, result.getWidth() / (int) Math.sqrt(sizeMultiplier), result.getHeight() / (int) Math.sqrt(sizeMultiplier), false);
        return result;
    }
}