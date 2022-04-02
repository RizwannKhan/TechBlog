package com.techblog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

	public static boolean deleteFile(String path) {
		boolean st = false;

		try {
			File file = new File(path);
			st = file.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return st;
	}

	public static boolean saveFile(InputStream is, String path) {
		boolean st = false;

		try {
			byte[] b = new byte[is.available()];
			is.read(b);
			FileOutputStream fos = new FileOutputStream(path);
			fos.write(b);
			fos.flush();
			fos.close();
			st = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return st;
	}

}
