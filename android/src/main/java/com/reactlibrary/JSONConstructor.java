package com.reactlibrary;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Point;
import android.graphics.Rect;
import android.util.Base64;

import com.regula.facesdk.enums.*;
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
import com.regula.facesdk.model.results.matchfaces.MatchFacesSimilarityThresholdSplit;
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
        if (list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(t);

        return result;
    }

    static <T> JSONArray generateList(List<T> list, JSONObjectGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        if (list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(generator.generateJSONObject(t));

        return result;
    }

    static <T> JSONArray generateList(List<T> list, StringGenerator<T> generator) {
        JSONArray result = new JSONArray();
        if (list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(generator.generateString(t));

        return result;
    }

    static <T> JSONArray generateList(List<T> list, JSONObjectGeneratorWithContext<T> generator, Context context) throws JSONException {
        JSONArray result = new JSONArray();
        if (list == null) return result;
        for (T t : list)
            if (t != null)
                result.put(generator.generateJSONObject(t, context));

        return result;
    }

    static <T> JSONArray generateArray(T[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static <T> JSONArray generateArray(T[] array, JSONObjectGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateJSONObject(array[i]));

        return result;
    }

    static <T> JSONArray generateArray(T[] array, StringGenerator<T> generator) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateString(array[i]));

        return result;
    }

    static <T> JSONArray generateArray(T[] array, JSONObjectGeneratorWithContext<T> generator, Context context) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, generator.generateJSONObject(array[i], context));

        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map) throws JSONException {
        JSONObject result = new JSONObject();
        if (map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), entry.getValue());
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, JSONObjectGenerator<V> generator) throws JSONException {
        JSONObject result = new JSONObject();
        if (map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateJSONObject(entry.getValue()));
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, StringGenerator<V> generator) throws JSONException {
        JSONObject result = new JSONObject();
        if (map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateString(entry.getValue()));
        return result;
    }

    static <T, V> JSONObject generateMap(Map<T, V> map, JSONObjectGeneratorWithContext<V> generator, Context context) throws JSONException {
        JSONObject result = new JSONObject();
        if (map == null) return result;
        for (Map.Entry<T, V> entry : map.entrySet())
            if (entry != null)
                result.put(entry.getKey().toString(), generator.generateJSONObject(entry.getValue(), context));
        return result;
    }

    static JSONArray generateIntArray(int[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateBooleanArray(boolean[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateDoubleArray(double[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateByteArray(byte[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
        for (int i = 0; i < array.length; i++)
            result.put(i, array[i]);

        return result;
    }

    static JSONArray generateLongArray(long[] array) throws JSONException {
        JSONArray result = new JSONArray();
        if (array == null) return result;
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
            int imageType = 0;
            if (input.has("imageType"))
                imageType = input.getInt("imageType");
            Bitmap bitmap = null;
            if (input.has("bitmap"))
                bitmap = BitmapFromJSON(input.getString("bitmap"));
            boolean detectAll = false;
            if (input.has("detectAll"))
                detectAll = input.getBoolean("detectAll");
            return new MatchFacesImage(bitmap, ImageTypeFromJSON(imageType), detectAll);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static Image ImageFromJSON(JSONObject input) {
        try {
            int imageType = 0;
            if (input.has("imageType"))
                imageType = input.getInt("imageType");
            Bitmap bitmap = null;
            if (input.has("bitmap"))
                bitmap = BitmapFromJSON(input.getString("bitmap"));
            String tag = null;
            if (input.has("tag"))
                tag = input.getString("tag");
            return new Image(ImageTypeFromJSON(imageType), tag, bitmap);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static List<MatchFacesComparedFacesPair> MatchFacesComparedFacesPairListFromJSON(JSONArray input) {
        List<MatchFacesComparedFacesPair> result = new ArrayList<>();
        if(input == null) return result;
        try {
            for (int i = 0; i < input.length(); i++)
                result.add(MatchFacesComparedFacesPairFromJSON(input.getJSONObject(i)));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static MatchFacesComparedFacesPair MatchFacesComparedFacesPairFromJSON(JSONObject input) {
        try {
            MatchFacesComparedFace first = null;
            if (input.has("first"))
                first = MatchFacesComparedFaceFromJSON(input.getJSONObject("first"));
            MatchFacesComparedFace second = null;
            if (input.has("second"))
                second = MatchFacesComparedFaceFromJSON(input.getJSONObject("second"));
            MatchFacesException exception = null;
            if (input.has("exception"))
                exception = MatchFacesExceptionFromJSON(input.getJSONObject("exception"));
            float similarity = 0;
            if (input.has("similarity"))
                similarity = (float)input.getDouble("similarity");
            float score = 0;
            if (input.has("score"))
                score = (float)input.getDouble("score");
            return new MatchFacesComparedFacesPair.a().a(first, second, exception, similarity, score).a();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesException MatchFacesExceptionFromJSON(JSONObject input) {
        try {
            if (input.has("errorCode"))
                return new MatchFacesException(MatchFacesErrorCodeFromJSON(input.getInt("errorCode")));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesComparedFace MatchFacesComparedFaceFromJSON(JSONObject input) {
        try {
            int imageIndex = 0;
            if (input.has("imageIndex"))
                imageIndex = input.getInt("imageIndex");
            MatchFacesImage image = null;
            if (input.has("image"))
                image = MatchFacesImageFromJSON(input.getJSONObject("image"));
            int faceIndex = 0;
            if (input.has("faceIndex"))
                faceIndex = input.getInt("faceIndex");
            MatchFacesDetectionFace face = null;
            if (input.has("face"))
                face = MatchFacesDetectionFaceFromJSON(input.getJSONObject("face"));
            return new MatchFacesComparedFace.a().a(imageIndex, image, faceIndex, face).a();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static MatchFacesDetectionFace MatchFacesDetectionFaceFromJSON(JSONObject input) {
        try {
            int faceIndex = 0;
            if (input.has("faceIndex"))
                faceIndex = input.getInt("faceIndex");
            Double rotationAngle = null;
            if (input.has("rotationAngle"))
                rotationAngle = input.getDouble("rotationAngle");
            List<Point> landmarks = null;
            if (input.has("landmarks"))
                landmarks = PointListFromJSON(input.getJSONArray("landmarks"));
            Rect faceRect = null;
            if (input.has("faceRect"))
                faceRect = RectFromJSON(input.getJSONObject("faceRect"));
            return new MatchFacesDetectionFace.a().a(faceIndex, rotationAngle, landmarks, faceRect).a();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

    static List<Point> PointListFromJSON(JSONArray input) {
        List<Point> result = new ArrayList<>();
        if(input == null) return result;
        try {
            for (int i = 0; i < input.length(); i++) {
                JSONObject point = input.getJSONObject(i);
                int x = 0;
                if(point.has("x"))
                    x = point.getInt("x");
                int y = 0;
                if(point.has("y"))
                    y = point.getInt("y");
                result.add(new Point(x, y));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    // To JSON

    static JSONObject generateFaceCaptureException(FaceCaptureException input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("@enum", generateerrorCode(input.getErrorCode()));
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
            result.put("@enum", generateerrorCode(input.getErrorCode()));
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
            result.put("@enum", generateerrorCode(input.getErrorCode()));
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
            result.put("@enum", generateliveness(input.getLiveness()));
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
            result.put("@enum", generateimageType(input.getImageType()));
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
            result.put("@enum", generateimageType(input.getImageType()));
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

    static JSONObject generateMatchFacesSimilarityThresholdSplit(MatchFacesSimilarityThresholdSplit input) {
        JSONObject result = new JSONObject();
        if (input == null) return result;
        try {
            result.put("matchedFaces", generateList(input.getMatchedFaces(), JSONConstructor::generateMatchFacesComparedFacesPair));
            result.put("unmatchedFaces", generateList(input.getUnmatchedFaces(), JSONConstructor::generateMatchFacesComparedFacesPair));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return result;
    }

    static int generateImageType(ImageType input) {
        if (input == ImageType.PRINTED) return 1;
        if (input == ImageType.RFID) return 2;
        if (input == ImageType.LIVE) return 3;
        if (input == ImageType.DOCUMENT_WITH_LIVE) return 4;
        if (input == ImageType.EXTERNAL) return 5;
        return 0;
    }

    static int generateMatchFacesErrorCode(MatchFacesErrorCode input) {
        if (input == MatchFacesErrorCode.IMAGE_EMPTY) return 1;
        if (input == MatchFacesErrorCode.FACE_NOT_DETECTED) return 2;
        if (input == MatchFacesErrorCode.LANDMARKS_NOT_DETECTED) return 3;
        if (input == MatchFacesErrorCode.FACE_ALIGNER_FAILED) return 4;
        if (input == MatchFacesErrorCode.DESCRIPTOR_EXTRACTOR_ERROR) return 5;
        if (input == MatchFacesErrorCode.NO_LICENSE) return 6;
        if (input == MatchFacesErrorCode.IMAGES_COUNT_LIMIT_EXCEEDED) return 7;
        if (input == MatchFacesErrorCode.API_CALL_FAILED) return 8;
        if (input == MatchFacesErrorCode.PROCESSING_FAILED) return 9;
        return 0;
    }

    static int generateFaceCaptureErrorCode(FaceCaptureErrorCode input) {
        if (input == FaceCaptureErrorCode.CANCEL) return 1;
        if (input == FaceCaptureErrorCode.CAMERA_NOT_AVAILABLE) return 2;
        if (input == FaceCaptureErrorCode.CAMERA_NO_PERMISSION) return 3;
        if (input == FaceCaptureErrorCode.IN_PROGRESS_ALREADY) return 4;
        if (input == FaceCaptureErrorCode.CONTEXT_IS_NULL) return 5;
        return 0;
    }

    static int generateLivenessErrorCode(LivenessErrorCode input) {
        if (input == LivenessErrorCode.CONTEXT_IS_NULL) return 1;
        if (input == LivenessErrorCode.IN_PROGRESS_ALREADY) return 2;
        if (input == LivenessErrorCode.ZOOM_NOT_SUPPORTED) return 3;
        if (input == LivenessErrorCode.NO_LICENSE) return 4;
        if (input == LivenessErrorCode.CANCELLED) return 5;
        if (input == LivenessErrorCode.PROCESSING_TIMEOUT) return 6;
        if (input == LivenessErrorCode.API_CALL_FAILED) return 7;
        if (input == LivenessErrorCode.PROCESSING_FAILED) return 8;
        return 0;
    }

    static int generateLivenessStatus(LivenessStatus input) {
        if (input == LivenessStatus.PASSED) return 0;
        if (input == LivenessStatus.UNKNOWN) return 1;
        return 0;
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

    static ImageType ImageTypeFromJSON(int input) {
        switch (input) {
            case 1:
                return ImageType.PRINTED;
            case 2:
                return ImageType.RFID;
            case 3:
                return ImageType.LIVE;
            case 4:
                return ImageType.DOCUMENT_WITH_LIVE;
            case 5:
                return ImageType.EXTERNAL;
            default:
                return null;
        }
    }

    static MatchFacesErrorCode MatchFacesErrorCodeFromJSON(int input) {
        switch (input) {
            case 1:
                return MatchFacesErrorCode.IMAGE_EMPTY;
            case 2:
                return MatchFacesErrorCode.FACE_NOT_DETECTED;
            case 3:
                return MatchFacesErrorCode.LANDMARKS_NOT_DETECTED;
            case 4:
                return MatchFacesErrorCode.FACE_ALIGNER_FAILED;
            case 5:
                return MatchFacesErrorCode.DESCRIPTOR_EXTRACTOR_ERROR;
            case 6:
                return MatchFacesErrorCode.NO_LICENSE;
            case 7:
                return MatchFacesErrorCode.IMAGES_COUNT_LIMIT_EXCEEDED;
            case 8:
                return MatchFacesErrorCode.API_CALL_FAILED;
            case 9:
                return MatchFacesErrorCode.PROCESSING_FAILED;
            default:
                return null;
        }
    }

    static FaceCaptureErrorCode FaceCaptureErrorCodeFromJSON(int input) {
        switch (input) {
            case 1:
                return FaceCaptureErrorCode.CANCEL;
            case 2:
                return FaceCaptureErrorCode.CAMERA_NOT_AVAILABLE;
            case 3:
                return FaceCaptureErrorCode.CAMERA_NO_PERMISSION;
            case 4:
                return FaceCaptureErrorCode.IN_PROGRESS_ALREADY;
            case 5:
                return FaceCaptureErrorCode.CONTEXT_IS_NULL;
            default:
                return null;
        }
    }

    static LivenessErrorCode LivenessErrorCodeFromJSON(int input) {
        switch (input) {
            case 1:
                return LivenessErrorCode.CONTEXT_IS_NULL;
            case 2:
                return LivenessErrorCode.IN_PROGRESS_ALREADY;
            case 3:
                return LivenessErrorCode.ZOOM_NOT_SUPPORTED;
            case 4:
                return LivenessErrorCode.NO_LICENSE;
            case 5:
                return LivenessErrorCode.CANCELLED;
            case 6:
                return LivenessErrorCode.PROCESSING_TIMEOUT;
            case 7:
                return LivenessErrorCode.API_CALL_FAILED;
            case 8:
                return LivenessErrorCode.PROCESSING_FAILED;
            default:
                return null;
        }
    }

    static LivenessStatus LivenessStatusFromJSON(int input) {
        switch (input) {
            case 0:
                return LivenessStatus.PASSED;
            case 1:
                return LivenessStatus.UNKNOWN;
            default:
                return null;
        }
    }
}