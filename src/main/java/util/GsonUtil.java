package util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;

/**
 * VO의 LocalDate 타입이나 LocalDateTime 타입을 json에서 처리할 수 있도록 등록한 GsonUtil.getInstance()이용
 * Gson gson = GsonUtil.getInstance();
 * String jsonData = gson.~~처럼 사용
 */
public class GsonUtil {
	private static final Gson gson;

	static {
		gson = new GsonBuilder()
	            .registerTypeAdapter(LocalDateTime.class,
	                (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context) ->
	                    new JsonPrimitive(src.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME))
	            )
	            .registerTypeAdapter(LocalDate.class,
	                (JsonSerializer<LocalDate>) (src, typeOfSrc, context) ->
	                    new JsonPrimitive(src.format(DateTimeFormatter.ISO_LOCAL_DATE))
	            )
	            .create();
	}

	public static Gson getInstance() {
		return gson;
	}
}
