package com.reactlibrary;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import com.regula.facesdk.exception.ComparedFacesPairException;
import com.regula.facesdk.exception.FaceCaptureException;
import com.regula.facesdk.exception.LivenessErrorException;
import com.regula.facesdk.exception.MatchFacesException;
import com.regula.facesdk.model.Image;
import com.regula.facesdk.model.results.ComparedFace;
import com.regula.facesdk.model.results.ComparedFacesPair;
import com.regula.facesdk.model.results.FaceCaptureResponse;
import com.regula.facesdk.model.results.LivenessResponse;
import com.regula.facesdk.model.results.MatchFacesResponse;
import com.regula.facesdk.request.MatchFacesRequest;

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

    static MatchFacesRequest MatchFacesRequestFromJSON(JSONObject input) {
        try {
            MatchFacesRequest result;
            List<Image> images = new ArrayList<>();
            if (input.has("images")) {
                JSONArray jsonArray_images = input.getJSONArray("images");
                for (int i = 0; i < jsonArray_images.length(); i++)
                    images.add(ImageFromJSON(jsonArray_images.getJSONObject(i)));
            }
            if (input.has("similarityThreshold")) {
                float similarityThreshold = (float) input.getDouble("similarityThreshold");
                result = new MatchFacesRequest(images, similarityThreshold);
            } else
                result = new MatchFacesRequest(images);
            if (input.has("customMetadata"))
                result.setCustomMetadata(new JSONObject(input.getString("customMetadata")));
            return result;
        } catch (JSONException ignored) {
        }
        return null;
    }

    // To JSON

    static JSONObject generateFaceCaptureException(FaceCaptureException input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateLivenessErrorException(LivenessErrorException input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesException(MatchFacesException input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateComparedFacesPairException(ComparedFacesPairException input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("errorCode", input.getErrorCode());
            result.put("message", input.getMessage());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateComparedFace(ComparedFace input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("tag", input.getTag());
            result.put("imageType", input.getImageType());
            result.put("position", input.getPosition());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateComparedFacesPair(ComparedFacesPair input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("first", generateComparedFace(input.getFirst()));
            result.put("second", generateComparedFace(input.getSecond()));
            result.put("similarity", input.getSimilarity());
            result.put("exception", generateComparedFacesPairException(input.getException()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateFaceCaptureResponse(FaceCaptureResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
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
        if (input == null) return result;
        try {
            result.put("bitmap", generateBitmap(input.getBitmap()));
            result.put("liveness", input.getLiveness());
            result.put("exception", generateLivenessErrorException(input.getException()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesResponse(MatchFacesResponse input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("exception", generateMatchFacesException(input.getException()));
            result.put("matchedFaces", generateList(input.getMatchedFaces(), JSONConstructor::generateComparedFacesPair));
            result.put("unmatchedFaces", generateList(input.getUnmatchedFaces(), JSONConstructor::generateComparedFacesPair));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateImage(Image input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("imageType", input.getImageType());
            result.put("tag", input.getTag());
            result.put("bitmap", generateBitmap(input.getBitmap()));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesRequest(MatchFacesRequest input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("similarityThreshold", input.getSimilarityThreshold());
            result.put("images", generateList(input.getImages(), JSONConstructor::generateImage));
            result.put("customMetadata", input.getCustomMetadata());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    // From JSON

    static Image ImageFromJSON(JSONObject input) {
        try {
            int imageType = input.getInt("imageType");
            Bitmap bitmap = null;
            if (input.has("bitmap"))
                bitmap = BitmapFromJSON(input.getString("bitmap"));
            Image result = new Image(imageType, bitmap);
            if (input.has("tag"))
                result.setTag(input.getString("tag"));
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}