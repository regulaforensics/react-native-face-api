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

    static String generateBitmap(Bitmap input) {
        if (input == null) return "";
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        input.compress(Bitmap.CompressFormat.JPEG, 100, byteArrayOutputStream);
        byte[] byteArray = byteArrayOutputStream.toByteArray();

        return Base64.encodeToString(byteArray, Base64.DEFAULT);
    }

    static Bitmap BitmapFromJSON(String input) {
        byte[] decodedString = Base64.decode(input, Base64.DEFAULT);
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPreferredConfig = Bitmap.Config.RGB_565;
        Bitmap result = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length, options);
        int sizeMultiplier = result.getByteCount() / 5000000;
        if (result.getByteCount() > 5000000)
            result = Bitmap.createScaledBitmap(result, result.getWidth() / (int) Math.sqrt(sizeMultiplier), result.getHeight() / (int) Math.sqrt(sizeMultiplier), false);
        return result;
    }

    static FaceCaptureError FaceCaptureErrorFromJSON(JSONObject input) {
        try {
            return new FaceCaptureError(input.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    static FaceProcessorError FaceProcessorErrorFromJSON(JSONObject input) {
        try {
            return new FaceProcessorError(input.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    static LivenessError LivenessErrorFromJSON(JSONObject input) {
        try {
            return new LivenessError(input.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    static MatchFacesError MatchFacesErrorFromJSON(JSONObject input) {
        try {
            return new MatchFacesError(input.getInt("errorCode"));
        } catch (JSONException e) {
            return null;
        }
    }

    // To JSON

    static JSONObject generateFaceCaptureError(FaceCaptureError input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateFaceProcessorError(FaceProcessorError input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessError(LivenessError input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateMatchFacesError(MatchFacesError input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessParams(LivenessParams input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("attemptsCount", input.attemptsCount);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateAgeRange(AgeRange input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("high", input.high);
            result.put("low", input.low);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateComparedFace(ComparedFace input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("tag", input.tag);
            result.put("imageType", input.imageType);
            result.put("position", input.position);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateComparedFacesPair(ComparedFacesPair input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("first", generateComparedFace(input.first));
            result.put("second", generateComparedFace(input.second));
            result.put("similarity", input.similarity);
            result.put("error", generateMatchFacesError(input.error));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateEthnicity(Ethnicity input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("confidence", input.confidence);
            result.put("value", input.value);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateFaceCaptureResponse(FaceCaptureResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("error", generateFaceCaptureError(input.error));
            result.put("image", generateImage(input.image));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateGender(Gender input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("confidence", input.confidence);
            result.put("value", input.value);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLandmark(Landmark input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("type", input.type);
            result.put("x", input.x);
            result.put("y", input.y);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessResponse(LivenessResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("bitmap", generateBitmap(input.getBitmap()));
            result.put("liveness", input.liveness);
            result.put("error", generateLivenessError(input.error));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateMatchFacesResponse(MatchFacesResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("error", generateFaceProcessorError(input.error));
            result.put("matchedFaces", generateList(input.matchedFaces, JSONConstructor::generateComparedFacesPair));
            result.put("unmatchedFaces", generateList(input.unmatchedFaces, JSONConstructor::generateComparedFacesPair));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateImage(Image input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("imageType", input.imageType);
            result.put("tag", input.tag);
            result.put("bitmap", generateBitmap(input.getBitmap()));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateLivenessRequest(LivenessRequest input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("normalImageData", generateByteArray(input.normalImageData));
            result.put("scaledImageData", generateByteArray(input.scaledImageData));
            result.put("requestBody", generateByteArray(input.getRequestBody()));
            result.put("guid", input.guid);
        } catch (JSONException ignored) {
        }
        return result;
    }

    static JSONObject generateMatchFacesRequest(MatchFacesRequest input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("similarityThreshold", input.similarityThreshold);
            result.put("images", generateList(input.images, JSONConstructor::generateImage));
            result.put("customMetadata", input.customMetadata);
        } catch (JSONException ignored) {
        }
        return result;
    }

    // From JSON

    static LivenessParams LivenessParamsFromJSON(JSONObject input) {
        LivenessParams result = new LivenessParams();
        try {
            if (input.has("attemptsCount"))
                result.attemptsCount = input.getInt("attemptsCount");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static AgeRange AgeRangeFromJSON(JSONObject input) {
        AgeRange result = new AgeRange();
        try {
            if (input.has("high"))
                result.high = input.getInt("high");
            if (input.has("low"))
                result.low = input.getInt("low");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static ComparedFace ComparedFaceFromJSON(JSONObject input) {
        ComparedFace result = new ComparedFace();
        try {
            if (input.has("tag"))
                result.tag = input.getString("tag");
            if (input.has("imageType"))
                result.imageType = input.getInt("imageType");
            if (input.has("position"))
                result.position = input.getInt("position");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static ComparedFacesPair ComparedFacesPairFromJSON(JSONObject input) {
        ComparedFacesPair result = new ComparedFacesPair();
        try {
            if (input.has("first"))
                result.first = ComparedFaceFromJSON(input.getJSONObject("first"));
            if (input.has("second"))
                result.second = ComparedFaceFromJSON(input.getJSONObject("second"));
            if (input.has("similarity"))
                result.similarity = input.getDouble("similarity");
            if (input.has("error"))
                result.error = MatchFacesErrorFromJSON(input.getJSONObject("error"));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Ethnicity EthnicityFromJSON(JSONObject input) {
        Ethnicity result = new Ethnicity();
        try {
            if (input.has("confidence"))
                result.confidence = input.getInt("confidence");
            if (input.has("value"))
                result.value = input.getInt("value");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static FaceCaptureResponse FaceCaptureResponseFromJSON(JSONObject input) {
        FaceCaptureResponse result = new FaceCaptureResponse();
        try {
            if (input.has("error"))
                result.error = FaceCaptureErrorFromJSON(input.getJSONObject("error"));
            if (input.has("image"))
                result.image = ImageFromJSON(input.getJSONObject("image"));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Gender GenderFromJSON(JSONObject input) {
        Gender result = new Gender();
        try {
            if (input.has("confidence"))
                result.confidence = (float) input.getDouble("confidence");
            if (input.has("value"))
                result.value = input.getInt("value");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Landmark LandmarkFromJSON(JSONObject input) {
        Landmark result = new Landmark();
        try {
            if (input.has("type"))
                result.type = input.getInt("type");
            if (input.has("x"))
                result.x = input.getInt("x");
            if (input.has("y"))
                result.y = input.getInt("y");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static LivenessResponse LivenessResponseFromJSON(JSONObject input) {
        LivenessResponse result = new LivenessResponse();
        try {
            if (input.has("liveness"))
                result.liveness = input.getInt("liveness");
            if (input.has("error"))
                result.error = LivenessErrorFromJSON(input.getJSONObject("error"));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static MatchFacesResponse MatchFacesResponseFromJSON(JSONObject input) {
        MatchFacesResponse result = new MatchFacesResponse();
        try {
            if (input.has("error"))
                result.error = FaceProcessorErrorFromJSON(input.getJSONObject("error"));
            if (input.has("matchedFaces")){
                JSONArray jsonArray = input.getJSONArray("matchedFaces");
                ArrayList<ComparedFacesPair> array = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++)
                    array.add(ComparedFacesPairFromJSON(jsonArray.getJSONObject(i)));
                result.matchedFaces = array;
            }
            if (input.has("unmatchedFaces")){
                JSONArray jsonArray = input.getJSONArray("unmatchedFaces");
                ArrayList<ComparedFacesPair> array = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++)
                    array.add(ComparedFacesPairFromJSON(jsonArray.getJSONObject(i)));
                result.unmatchedFaces = array;
            }
        } catch (JSONException ignored) {
        }
        return result;
    }

    static Image ImageFromJSON(JSONObject input) {
        Image result = new Image();
        try {
            if (input.has("imageType"))
                result.imageType = input.getInt("imageType");
            if (input.has("tag"))
                result.tag = input.getString("tag");
            if (input.has("bitmap"))
                result.setImage(BitmapFromJSON(input.getString("bitmap")));
        } catch (JSONException ignored) {
        }
        return result;
    }

    static LivenessRequest LivenessRequestFromJSON(JSONObject input) {
        LivenessRequest result = new LivenessRequest();
        try {
            if (input.has("normalImageData")){
                JSONArray jsonArray = input.getJSONArray("normalImageData");
                byte[] array = new byte[jsonArray.length()];
                for (int i = 0; i < jsonArray.length(); i++)
                    array[i] = (byte) jsonArray.get(i);
                result.normalImageData = array;
            }
            if (input.has("scaledImageData")){
                JSONArray jsonArray = input.getJSONArray("scaledImageData");
                byte[] array = new byte[jsonArray.length()];
                for (int i = 0; i < jsonArray.length(); i++)
                    array[i] = (byte) jsonArray.get(i);
                result.scaledImageData = array;
            }
            if (input.has("guid"))
                result.guid = input.getString("guid");
        } catch (JSONException ignored) {
        }
        return result;
    }

    static MatchFacesRequest MatchFacesRequestFromJSON(JSONObject input) {
        MatchFacesRequest result = new MatchFacesRequest();
        try {
            if (input.has("similarityThreshold"))
                result.similarityThreshold = (float) input.getDouble("similarityThreshold");
            if (input.has("images")){
                JSONArray jsonArray = input.getJSONArray("images");
                ArrayList<Image> array = new ArrayList<>();
                for (int i = 0; i < jsonArray.length(); i++)
                    array.add(ImageFromJSON(jsonArray.getJSONObject(i)));
                result.images = array;
            }
            if (input.has("customMetadata"))
                result.customMetadata = new JSONObject(input.getString("customMetadata"));
        } catch (JSONException ignored) {
        }
        return result;
    }
}