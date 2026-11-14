package io.github.e1000i0.hanger;

import static org.assertj.core.api.Assertions.assertThat;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class SaludHttpTests {

	@LocalServerPort
	private int puerto;

	@Test
	void healthDevuelve200YEstadoUp() throws Exception {
		HttpRequest peticion = HttpRequest.newBuilder(
				URI.create("http://localhost:" + puerto + "/actuator/health")).GET().build();

		HttpResponse<String> respuesta = HttpClient.newHttpClient()
				.send(peticion, HttpResponse.BodyHandlers.ofString());

		assertThat(respuesta.statusCode()).isEqualTo(200);
		assertThat(respuesta.body()).contains("\"status\":\"UP\"");
	}

}
