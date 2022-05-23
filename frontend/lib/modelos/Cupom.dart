class Cupom{
  final int id;
  final double num_valor;
  final String des_chave;
  final bool bool_usado;
  final String dat_expiracao;
  final String des_status;
  final String dat_criacao;
  final int cod_doador;

  Cupom({
    required this.id,
    required this.num_valor,
    required this.des_chave,
    required this.bool_usado,
    required this.dat_expiracao,
    required this.des_status,
    required this.dat_criacao,
    required this.cod_doador
  });
}