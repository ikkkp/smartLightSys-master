package com.example.demo_traffic.Service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;

import com.google.common.collect.Lists;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber.Exception;
import org.bytedeco.javacv.Java2DFrameConverter;

/**
 * 视频抽帧
 *
 */
public class VideoProcessor {

//    public static void main(String[] args) throws Exception {
//        String filePath = "C:\\Users\\24964\\Desktop\\demo.mp4";	//批量处理，视频所在文件夹
//        String targetPath = "C:\\Users\\24964\\Desktop\\";	//输出图片文件夹
//        File file = new File(filePath);
//        if (file.isDirectory()){
//            File[] files = file.listFiles();
//            for (int i=0; i<files.length; i++) {
//                String fpath = files[i].getParent()+"\\"+files[i].getName();
//                System.out.println(fpath);
//                String fileName = files[i].getName();
//                randomGrabberFFmpegImage(fpath, targetPath, fileName.substring(0, fileName.length()-4));
//            }
//        }
//    }
//
//
//    public static void randomGrabberFFmpegImage(String filePath, String targerFilePath, String targetFileName)
//            throws Exception {
//        FFmpegFrameGrabber ff = FFmpegFrameGrabber.createDefault(filePath);
//        ff.start();
//        int ffLength = ff.getLengthInFrames();
//        System.out.println(ffLength);
////        double fr = ff.getFrameRate();  //帧率
//        System.out.println("帧率: " + ff.getFrameRate());
//
//        System.out.println("视频长度: " + ff.getLengthInTime());
//        Frame f;
//        int t = 10;		//抽帧间隔
//        for (int k=0; k<ffLength; k++){
//            f = ff.grabImage();
//            if (k%t==0){
//                doExecuteFrame(f, targerFilePath, targetFileName, k);
//            }
//        }
//        ff.stop();
//    }
//
//    public static void doExecuteFrame(Frame f, String targerFilePath, String targetFileName, int index) {
//        if (null == f || null == f.image) {
//            return;
//        }
//
//        Java2DFrameConverter converter = new Java2DFrameConverter();
//
//        String imageMat = "jpg";
//        String FileName = targerFilePath + File.separator + targetFileName + "_" + index + "." + imageMat;
//        BufferedImage bi = converter.getBufferedImage(f);
//        File output = new File(FileName);
//        try {
//            ImageIO.write(bi, imageMat, output);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
    /**
     * 视频文件指定时间段的帧截取
     * @param file
     * @param start
     * @param end
     */
    public static List<File> videoIntercept(File file, Integer start, Integer end) {
        Frame frame = null;
        List<File> files = Lists.newArrayList();
        FFmpegFrameGrabber fFmpegFrameGrabber = new FFmpegFrameGrabber(file);
        String filePath = "C://Users//24964//Desktop//";
        String fileTargetName = "movie";
        try {
            fFmpegFrameGrabber.start();
            int ftp = fFmpegFrameGrabber.getLengthInFrames();
            System.out.println("开始视频提取帧");
            for (int i=0 ; i < ftp ; i++){
                if( i >= start && i <= end){
                    frame = fFmpegFrameGrabber.grabImage();
                    doExecuteFrame(frame, filePath, fileTargetName, i ,files);
                }
            }
            System.out.println("============运行结束============");
            fFmpegFrameGrabber.stop();
        } catch (IOException E) {
//      Loggers.ERROR.error("视频抽帧异常", e);
        }
        return files;
    }

    public static void doExecuteFrame(Frame frame, String targetFilePath, String targetFileName, int index ,List<File> files) {
        if ( frame == null || frame.image == null) {
            return;
        }
        Java2DFrameConverter converter = new Java2DFrameConverter();
        String imageMat = "jpg";
        String fileName = targetFilePath + targetFileName + "_" + index + "." + imageMat;
        BufferedImage bi = converter.getBufferedImage(frame);
        File output = new File(fileName);
        files.add(output);
        try{
            ImageIO.write(bi, imageMat, output);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        List<File> files = videoIntercept(new File("C://Users//24964//Desktop//demo.mp4"), 10, 30);
        System.out.println(files);
    }

}

