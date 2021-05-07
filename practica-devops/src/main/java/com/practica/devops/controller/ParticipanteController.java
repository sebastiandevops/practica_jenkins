package com.practica.devops.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.practica.devops.model.Participante;
import com.practica.devops.service.ParticipanteService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/devops")
@CrossOrigin
public class ParticipanteController {

	@Autowired
	ParticipanteService participanteService;

	@GetMapping("/participantes")
	public List<Participante> obtenerParticipantes() {
		return participanteService.obtenerTodos();
	}

	@GetMapping("/participantes/{id}")
	public Participante obtenerParticipanteId(@PathVariable(value = "id") Long id) {
		return participanteService.obtenerParticipanteId(id);
	}

	@PostMapping("/participantes")
	public Participante crearParticipante(@RequestBody Participante participante) {
		Participante p = participanteService.crearParticipante(participante);
		p.setId(123456L);
		return p;
	}

	@PutMapping("/participantes/{id}")
	public Participante actualizarParticipante(@PathVariable(value = "id") Long id,
			@RequestBody Participante participante) {
		return participanteService.actualizarParticipante(id, participante);
	}

	@DeleteMapping("/participantes/{id}")
	public Participante eliminarParticipante(@PathVariable(value = "id") Long id) {
		return participanteService.eliminarParticipante(id);
	}

}
