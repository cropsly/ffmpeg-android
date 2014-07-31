package com.vinsol.androidffmpeg.sampleffmpegapp;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import java.io.File;
import java.io.IOException;

public class MyActivity extends Activity {

    private static final String TAG = MyActivity.class.getSimpleName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my);
        new CopyAndLoadFFmpegBinaryToAssets().execute();
    }

    private class CopyAndLoadFFmpegBinaryToAssets extends AsyncTask<Void, Void, Boolean> {

        @Override
        protected Boolean doInBackground(Void... params) {
            cpuArchHelper cpuArchHelper = new cpuArchHelper();
            String  cpuInfoString = cpuArchHelper.cpuArchFromJNI();
            boolean isARM_v7_CPU = cpuArchHelper.isARM_v7_CPU(cpuInfoString);

            // check if CPU type supported
            // check if CPU is ARM v7 and if not return false
            // (We are currently only supporting ARM v7 devices)
            if(isARM_v7_CPU) {
                Log.d(TAG, "ARM v7 CPU");
                // choose ffmpeg binary name (either neon or v7)
                String ffmpegBinaryName = cpuArchHelper.isNeonSupported(cpuInfoString) ? "ffmpeg-armeabi-v7a-neon": "ffmpeg-armeabi-v7a";

                boolean hasFileCopied = FileUtils.copyBinaryFromAssetsToData(MyActivity.this, ffmpegBinaryName, FileUtils.ffmpegFileName);

                // make directory executable
                if (hasFileCopied) {
                    String filesDirectoryPath = FileUtils.getFilesDirectory(MyActivity.this).getAbsolutePath();
                    File ffmpegFile = new File(filesDirectoryPath + File.separator + FileUtils.ffmpegFileName);

                    if(!ffmpegFile.canExecute()) {
                        Log.d(TAG, "FFmpeg File is not executable, trying to make it executable ...");
                        if (ffmpegFile.setExecutable(true)) {
                            return true;
                        }
                    } else {
                        Log.d(TAG, "FFmpeg file is executable");
                        return true;
                    }
                }

            } else {
                Log.d(TAG, "NOT an ARM v7 CPU. ****** NOT SUPPORTED ********** ");
            }
            return false;
        }

        @Override
        protected void onPostExecute(Boolean loaded) {
            if (loaded) {
                try {
                    Process process = Runtime.getRuntime().exec(FileUtils.getFFmpeg(MyActivity.this) + " -version");
                    if (process.waitFor() == 0) {
                        // success
                        String is = new String(FileUtils.inputStreamToByteArray(process.getInputStream()));
                        Log.d(TAG, "process.getInputStream returns : "+is);
                        setFFmpegTextViewText("SUCCESS : "+is);
                    } else {
                        // failure
                        String error = new String(FileUtils.inputStreamToByteArray(process.getErrorStream()));
                        Log.d(TAG, "process.getErrorStream returns : "+error);
                        setFFmpegTextViewText("ERROR : "+error);
                    }
                    Log.d(TAG, "process output : "+process.waitFor());
                } catch (IOException e) {
                    Log.e(TAG, "IOException while getting ffmpeg version", e);
                } catch (InterruptedException e) {
                    Log.e(TAG, "FFmpeg command interrupted", e);
                }
            }
        }
    }

    private void setFFmpegTextViewText(String text) {
        ((TextView) findViewById(R.id.ffmpeg_output)).setText(text);
    }
}
