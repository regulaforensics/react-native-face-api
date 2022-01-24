package com.reactlibrary;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.graphics.Rect;
import android.util.Base64;

import com.regula.facesdk.exception.FaceCaptureException;
import com.regula.facesdk.exception.LivenessErrorException;
import com.regula.facesdk.exception.MatchFacesException;
import com.regula.facesdk.model.Image;
import com.regula.facesdk.model.MatchFacesImage;
import com.regula.facesdk.model.results.FaceCaptureResponse;
import com.regula.facesdk.model.results.LivenessResponse;
import com.regula.facesdk.model.results.matchfaces.MatchFacesComparedFace;
import com.regula.facesdk.model.results.matchfaces.MatchFacesComparedFacesPair;
import com.regula.facesdk.model.results.matchfaces.MatchFacesDetection;
import com.regula.facesdk.model.results.matchfaces.MatchFacesDetectionFace;
import com.regula.facesdk.model.results.matchfaces.MatchFacesResponse;
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
            List<MatchFacesImage> images = new ArrayList<>();
            if (input.has("images")) {
                JSONArray jsonArray_images = input.getJSONArray("images");
                for (int i = 0; i < jsonArray_images.length(); i++)
                    images.add(MatchFacesImageFromJSON(jsonArray_images.getJSONObject(i)));
            }
            MatchFacesRequest result = new MatchFacesRequest(images);
            if (input.has("metadata"))
                result.setCustomMetadata(new JSONObject(input.getString("metadata")));
            if (input.has("thumbnails"))
                result.setThumbnails(input.getBoolean("thumbnails"));
            return result;
        } catch (JSONException ignored) {
        }
        return null;
    }

    static MatchFacesImage MatchFacesImageFromJSON(JSONObject input) {
        try {
            int imageType = input.getInt("imageType");
            Bitmap bitmap = null;
            if (input.has("bitmap"))
                bitmap = BitmapFromJSON(input.getString("bitmap"));
            boolean detectAll = false;
            if (input.has("detectAll"))
                detectAll = input.getBoolean("detectAll");
            return new MatchFacesImage(bitmap, imageType, detectAll);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Image ImageFromJSON(JSONObject input) {
        try {
            int imageType = input.getInt("imageType");
            Bitmap bitmap = null;
            if (input.has("bitmap"))
                bitmap = BitmapFromJSON(input.getString("bitmap"));
            String tag = null;
            if (input.has("tag"))
                tag = input.getString("tag");
            return new Image(imageType,tag, bitmap);
        } catch (JSONException e) {
            e.printStackTrace();
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
            result.put("guid", input.getGuid());
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
            result.put("detections", generateList(input.getDetections(), JSONConstructor::generateMatchFacesDetection));
            result.put("results", generateList(input.getResults(), JSONConstructor::generateMatchFacesComparedFacesPair));
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
            result.put("images", generateList(input.getImages(), JSONConstructor::generateMatchFacesImage));
            result.put("customMetadata", input.getCustomMetadata());
            result.put("thumbnails", input.isThumbnails());
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static JSONObject generateMatchFacesImage(MatchFacesImage input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("imageType", input.getImageType());
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
        if (input == null) return result;
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
        if (input == null) return result;
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
        if (input == null) return result;
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
        if (input == null) return result;
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
        if (input == null) return result;
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
        if (input == null) return result;
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

    // From JSON

    static Point PointFromJSON(JSONObject input) {
        try {
            Point result = new Point();
            if (input.has("x"))
                result.x = input.getInt("x");
            if (input.has("y"))
                result.y = input.getInt("y");
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Rect RectFromJSON(JSONObject input) {
        try {
            Rect result = new Rect();
            if (input.has("bottom"))
                result.bottom = input.getInt("bottom");
            if (input.has("top"))
                result.top = input.getInt("top");
            if (input.has("left"))
                result.left = input.getInt("left");
            if (input.has("right"))
                result.right = input.getInt("right");
            return result;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}