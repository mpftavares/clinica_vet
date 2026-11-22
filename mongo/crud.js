// CREATE — Abrir um episódio com a consulta inicial 
// e a primeira observação.
db.episodios.insertOne({
  _id: NumberInt(1000),
  animal: { id_animal: NumberInt(1), nome: 'Mia', especie: 'Gato', id_cliente: NumberInt(21) },
  data_hora_inicio: new Date(),
  atos: [
    {
      id_ato: NumberInt(1000),
      data_hora: new Date(),
      servico: { id_servico: NumberInt(1), designacao: 'Consulta' },
      colaborador: { id_colaborador: NumberInt(2), nome: 'Bruno Fernandes Lopes' },
      notas: 'Sintomas: vómitos. Diagnóstico: gastroenterite aguda.',
    },
  ],
  observacoes: [
    {
      id_observacao: NumberInt(1000),
      data_hora: new Date(),
      colaborador: { id_colaborador: NumberInt(2), nome: 'Bruno Fernandes Lopes' },
      peso: 4.2,
      temperatura: 39.1,
      freq_cardiaca: NumberInt(180),
    },
  ],
});


// READ — Consultar o episódio criado.
db.episodios.find({ _id: 1000 });


// UPDATE — Registar uma nova observação e encerrar o episódio.
db.episodios.updateOne(
  { _id: 1000 },
  {
    $push: {
      observacoes: {
        id_observacao: NumberInt(1001),
        data_hora: new Date(),
        colaborador: { id_colaborador: NumberInt(2), nome: 'Bruno Fernandes Lopes' },
        temperatura: 38.4,
        notas: 'Melhoria clínica; alta com dieta gastrointestinal.',
      },
    },
    $set: { data_hora_fim: new Date() },
  }
);

// DELETE — Eliminar o episódio criado.
db.episodios.deleteOne({ _id: 1000 });