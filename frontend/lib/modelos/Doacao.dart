class Doacao{
  final int id;
  final int cod_solicitante;
  final String nome_solicitante;
  final String sobrenome_solicitante;
  final String des_email_solicitante;
  final String des_telefone_solicitante;
  final int cod_beneficiario;
  final String nome_beneficiario;
  final String des_email_beneficiario;
  final String des_telefone_beneficiario;
  final String dat_dia;
  final String des_hora;
  final bool bool_confirmado;
  final String des_status_atual_atendimento;
  final String des_status_atual_doacao;
  final List<dynamic> materiais;

  Doacao({
    required this.id,
    required this.cod_solicitante,
    this.nome_solicitante = '',
    this.sobrenome_solicitante = '',
    this.des_email_solicitante = '',
    this.des_telefone_solicitante = '',
    required this.cod_beneficiario,
    this.nome_beneficiario = '',
    this.des_email_beneficiario = '',
    this.des_telefone_beneficiario = '',
    required this.dat_dia,
    required this.des_hora,
    required this.bool_confirmado,
    required this.des_status_atual_atendimento,
    required this.des_status_atual_doacao,
    required this.materiais
});

}