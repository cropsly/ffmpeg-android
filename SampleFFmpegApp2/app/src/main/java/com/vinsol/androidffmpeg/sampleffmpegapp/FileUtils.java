package com.vinsol.androidffmpeg.sampleffmpegapp;

import android.content.Context;
import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class FileUtils {

    private static final String TAG = FileUtils.class.getSimpleName();

	public static final String ffmpegFileName = "ffmpeg";
    private static final int DEFAULT_BUFFER_SIZE = 1024 * 4;
    private static final int EOF = -1;

    public static byte[] inputStreamToByteArray(InputStream input) {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];

        int n;
        try {
            while(EOF != (n = input.read(buffer)))
                output.write(buffer, 0, n);
            close(input);
            return output.toByteArray();
        } catch(IOException e) {
            Log.e(TAG, "FileUtils: IOException in converting inputStreamToByteArray", e);
        }
        return null;
    }

	public static boolean copyBinaryFromAssetsToData(Context context, String fileNameFromAssets, String outputFileName) {
		
		// create files directory under /data/data/package name
		File filesDirectory = getFilesDirectory(context);
		
		InputStream is;
		try {
			is = context.getAssets().open(fileNameFromAssets);
			// copy ffmpeg file from assets to files dir
			final FileOutputStream os = new FileOutputStream(new File(filesDirectory, outputFileName));
			byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
			
			int n;
			while(EOF != (n = is.read(buffer))) {
				os.write(buffer, 0, n);
			}

            close(os);
            close(is);
			
			return true;
		} catch (IOException e) {
			Log.e(TAG, "issue in coping binary from assets to data. ", e);
		}
        return false;
	}

	public static File getFilesDirectory(Context context) {
		// creates files directory under data/data/package name
        return context.getFilesDir();
	}
	
	public static void close(InputStream inputStream) {
	    if (inputStream != null) {
            try {
                inputStream.close();
            } catch (IOException e) {
                // Do nothing
            }
        }
	}
	
	public static void close(OutputStream outputStream) {
        if (outputStream != null) {
            try {
                outputStream.flush();
                outputStream.close();
            } catch (IOException e) {
                // Do nothing
            }
        }
    }

    public static String getFFmpeg(Context context) {
        return getFilesDirectory(context).getAbsolutePath() + File.separator + FileUtils.ffmpegFileName;
    }
}