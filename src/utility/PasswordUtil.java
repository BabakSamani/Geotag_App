package utility;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;
import org.apache.log4j.Logger;
import org.apache.commons.codec.binary.Base64;

public class PasswordUtil {

	private static org.apache.log4j.Logger Log = Logger.getLogger(PasswordUtil.class);

	public static String Cryptographer(String password) {

		MessageDigest md;
		String CryptedPass = "";
		try {
			md = MessageDigest.getInstance("SHA-256");
			md.update(password.getBytes());
			byte[] mdArray = md.digest();
			StringBuilder sb = new StringBuilder(mdArray.length * 2);
			for (byte b : mdArray) {
				int v = b & 0xff;
				if (v < 16) {
					sb.append('0');
				}
				sb.append(Integer.toHexString(v));
			}
			CryptedPass = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			Log.fatal("This is a fatal message from PasswordUtil class, Cryptographer method: ", e);
			Log.error("This is an error message from PasswordUtil class, Cryptographer method: ", e);
			Log.warn("This is a warn message from PasswordUtil class, Cryptographer method: ", e);
			Log.info("This is an info message from PasswordUtil class, Cryptographer method: ", e);
			Log.debug("This is a debug message from PasswordUtil class, Cryptographer method: ", e);
			Log.trace("This is a trace message from PasswordUtil class, Cryptographer method: ", e);
		}
		return CryptedPass;
	}

	public static String getSalt() {
		Random r = new SecureRandom();
		byte[] saltBytes = new byte[32];
		r.nextBytes(saltBytes);
		String stringToRetrun = Base64.encodeBase64(saltBytes).toString();
		return stringToRetrun;
	}

	public static String cryptedAndSaltPassword(String password) throws NoSuchAlgorithmException {
		String salt = getSalt();
		return Cryptographer(password + salt);
	}
	
}
