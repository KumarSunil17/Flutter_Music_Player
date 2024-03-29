package com.kumarsunil17.flutter_music_player;

import android.Manifest;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaMetadataRetriever;
import android.media.audiofx.AudioEffect;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "eq_settings";
    MediaMetadataRetriever metaRetriver;
    byte[] art;
    Map<String, String> song;
    Uri file;
    Intent intent;
    int requestcode = 1;

    @TargetApi(Build.VERSION_CODES.M)
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (call, result) -> {
              if (call.method.equals("equalizer")) {
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.GINGERBREAD) {
                  Intent intent = new Intent(AudioEffect.ACTION_DISPLAY_AUDIO_EFFECT_CONTROL_PANEL);
                  startActivityForResult(intent, 0);
                }
              } else {
                result.notImplemented();
              }
            });
      try {
          intent = getIntent();
          String action = intent.getAction();
          String[] permissions = {Manifest.permission.WRITE_EXTERNAL_STORAGE};
          if (action == Intent.ACTION_VIEW) {
              requestPermissions(permissions, requestcode);
              handle(intent);
              new MethodChannel(getFlutterView(), "app.channel.shared.data").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                  @Override
                  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                      if (methodCall.method.contentEquals("getSharedData")) {
                          result.success(song);
                      }
                  }
              });
          }
      }catch (Exception e){
          Log.d("cdve",e.getMessage());
      }
  }

    void handle(Intent intent){
        file=intent.getData();
        song=new HashMap<>();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD_MR1) {
            metaRetriver=new MediaMetadataRetriever();
            metaRetriver.setDataSource(file.getPath());
            try {
                art = metaRetriver.getEmbeddedPicture();
                song.put("album",metaRetriver .extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM));
                song.put("artist",metaRetriver .extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST));
                song.put("duration",metaRetriver.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION));
                String title=metaRetriver.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE);
                song.put("title",title);
                song.put("uri",file.getPath());
                if(art!=null){
                    Bitmap songImage = BitmapFactory.decodeByteArray(art, 0, art.length);
                    song.put("albumArt", saveToInternalStorage(songImage, title));
                }
                else{
                    song.put("albumArt",null);
                }

            } catch (Exception e) {
                Log.d("23456543",e.getMessage());
            }
        }
    }
    private String saveToInternalStorage(Bitmap bitmapImage, String title){
        ContextWrapper cw = new ContextWrapper(getApplicationContext());
        File directory = cw.getDir("thumbs", Context.MODE_PRIVATE);

        File file=new File(directory,title+".png");
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(file);
            bitmapImage.compress(Bitmap.CompressFormat.PNG, 50, fos);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return file.getAbsolutePath();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }
}
