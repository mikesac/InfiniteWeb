package org.infinite.web.utils;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.infinite.util.GenericUtil;
import org.infinite.util.ImageUtil;
import org.json.simple.JSONObject;

public class ControllerUtils {

	public static BufferedImage uploadAndResizeImage(HttpServletRequest request, String basePath,String imageName, String imageExt, int width, int heigth) throws FileUploadException, IOException, Exception,
	FileNotFoundException {
		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
		List<?> items = upload.parseRequest(request);

		String imgName = "";
		//	String fileName = "";
		InputStream is = null;

		Iterator<?> iter = items.iterator();			
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();

			if (item.isFormField()) {
				imgName = item.getString().trim();
			} else {
				is = item.getInputStream();
				//			fileName = item.getName();
			}
		}

		//validate imgName
		if(imgName==null || imgName.length()==0){
			throw new Exception("Please insert a valid name!");
		}
		BufferedImage img = null;
		if(is!=null && is.available()>0){

			String szFileName = basePath + (imageName!=null?imageName:imgName) +"."+imageExt;

			img = ImageUtil.getImagefromStream(is);
			
			//evaluate height to maintain proportions
			if(heigth<0){
				heigth = (width * img.getHeight())/ img.getWidth();
			}
			
			
			img = ImageUtil.scaleImage(img, width, heigth);
			saveImageToFile(img, szFileName,imageExt);
			is.close();
		}
		else{
			throw new Exception("No Image Data Avaiable");
		}
		return img;
	}
	
	public static void doubleUploadAndResizeImage(HttpServletRequest request, String bigPath,String smallPath,String imageName, String imageExt, int widthBig, int heigthBig, int widthSmall, int heigthSmall) throws FileUploadException, IOException, Exception,
	FileNotFoundException {
		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
		List<?> items = upload.parseRequest(request);

		String imgName = "";
		//	String fileName = "";
		InputStream is = null;

		Iterator<?> iter = items.iterator();			
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();

			if (item.isFormField()) {
				imgName = item.getString().trim();
			} else {
				is = item.getInputStream();
				//			fileName = item.getName();
			}
		}

		//validate imgName
		if(imgName==null || imgName.length()==0){
			throw new Exception("Please insert a valid name!");
		}
		BufferedImage img = null;
		if(is!=null && is.available()>0){

			String fileNameBig = bigPath + (imageName!=null?imageName:imgName) +"."+imageExt;
			String fileNameSml = smallPath + (imageName!=null?imageName:imgName) +"."+imageExt;

			img = ImageUtil.getImagefromStream(is);
			
			//evaluate height to maintain proportions
			if(heigthBig<0){
				heigthBig = (widthBig * img.getHeight())/ img.getWidth();
			}
			if(heigthSmall<0){
				heigthSmall = (widthSmall * img.getHeight())/ img.getWidth();
			}
			
			//fist big one
			img = ImageUtil.scaleImage(img, widthBig, heigthBig);
			saveImageToFile(img, fileNameBig,imageExt);
			
			//then again for small
			img = ImageUtil.scaleImage(img, widthSmall, heigthSmall);
			saveImageToFile(img, fileNameSml,imageExt);
			is.close();
		}
		else{
			throw new Exception("No Image Data Avaiable");
		}
	}


	public static void saveImageToFile(BufferedImage img,String fileName,String imageFormat) throws IOException, FileNotFoundException {
		ByteArrayOutputStream baos = ImageUtil.setImageToStream(img, imageFormat);

		File f = new File(fileName);
		f.createNewFile();
		FileOutputStream fos = new FileOutputStream(f);
		fos.write( baos.toByteArray());

		fos.flush();
		baos.flush();
		fos.close();
		baos.close();
	}


	@SuppressWarnings("unchecked")
	public static Object populateObject(Object object, JSONObject data,String prefix) throws Exception{

		Class<?> c = object.getClass();
		for (Iterator<String> iterator = data.keySet().iterator(); iterator.hasNext();) 
		{
			String key = iterator.next();
			String value = (String)data.get(key);
			if(key.startsWith(prefix)){
				key = key.substring(prefix.length());
			}
			else{
				continue;
			}

			String getter = "get" + key.substring(0,1).toUpperCase() + key.substring(1, key.length());
			String getter2 = "is" + key.substring(0,1).toUpperCase() + key.substring(1, key.length());
			String setter = "set" + key.substring(0,1).toUpperCase() + key.substring(1, key.length());

			//obtain type from getter
			Method m;
			try {
				m = c.getMethod(getter);
			} catch (NoSuchMethodException e) {
				m = c.getMethod(getter2);
			}			
			Class returnType = m.getReturnType();

			//use it to retrieve setter
			m = c.getMethod(setter, returnType);

			if(returnType.equals( String.class) ){
				m.invoke(object, value);
			}
			else if(returnType.equals( Integer.class)){
				int v = GenericUtil.toInt( value, -1);
				m.invoke(object, v);
			}
			else if(returnType.equals( Long.class) || returnType.equals(Float.class)|| returnType.toString().equalsIgnoreCase("float")){
				int v = GenericUtil.toInt( value, -1);
				m.invoke(object, (1.0f * v));
			}
			else if(returnType.equals( Boolean.class) || returnType.toString().equalsIgnoreCase("boolean")){
				boolean v = ( value.equalsIgnoreCase("true") || value.equalsIgnoreCase("1")|| value.equalsIgnoreCase("on"));
				m.invoke(object, v);
			}
			else{
				String msg="unrecognized reflection type:"+returnType.toString()+" from method "+m.toString();
				System.err.println(msg);
				throw new Exception(msg);
			}
		}		
		return object;
	}
	
	public static ArrayList<String> getFileList(String path) {
		ArrayList<String> l = new ArrayList<String>();
		File f = new File(path);
		if(f.exists() && f.isDirectory()){
			String[] imgList= f.list(null);
			for (int i = 0; i < imgList.length; i++) {
				
				if(imgList[i].indexOf(".")!=-1){
					l.add(imgList[i].substring(0,imgList[i].lastIndexOf(".")));
				}
			}
		}
		return l;
	}
	
}
