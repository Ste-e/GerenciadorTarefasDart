import 'dart:io';

class TarefaEstudos {
  String tarefa;
  DateTime dataEntrega;
  String status;
  String prazo;
  String kanban;

  TarefaEstudos(this.tarefa, this.dataEntrega, this.status, this.prazo, this.kanban);

  void exibirTarefas() {
    print("            Agenda           ");
    print("----------------------------");
    print("Tarefa: $tarefa");
    print("Data de Entrega: ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}");
    print("Horário de Entrega: ${dataEntrega.hour}:${dataEntrega.minute.toString().padLeft(2, '0')}");
    print("Status: $status");
    print("Prazo: $prazo");
    print("Kanban: $kanban");
    print("----------------------------\n");
  }
}

List<TarefaEstudos> organizar = [];

void tarefa() {
  bool adicionarMais = true;

  while (adicionarMais) {
    print("\nEscreva sua tarefa: ");
    String nome = stdin.readLineSync() ?? " ";

    print("Escreva Data de Entrega (dd/mm/aaaa): ");
    List<String> data = (stdin.readLineSync() ?? "01/01/2000").split("/");

    int dia = int.parse(data[0]);
    int mes = int.parse(data[1]);
    int ano = int.parse(data[2]);

    print("Escreva o horário de entrega (HH:MM): ");
    List<String> tempo = (stdin.readLineSync() ?? "00:00").split(":");
    int hora = int.parse(tempo[0]);
    int minuto = int.parse(tempo[1]);

    DateTime dataEntrega = DateTime(ano, mes, dia, hora, minuto);

    print("Status (ATRASADO - CONCLUIDO - PENDENTE): ");
    String status = stdin.readLineSync() ?? " ";

    print("Prazo (CURTO - MEDIO - LONGO): ");
    String prazo = stdin.readLineSync() ?? " ";

    print("Kanban (FAZER - FAZENDO - FEITO): ");
    String kanban = stdin.readLineSync() ?? " ";

    organizar.add(TarefaEstudos(
      nome,
      dataEntrega,
      status,
      prazo,
      kanban,
    ));

    print("\nTarefa adicionada com sucesso!");

    print("Deseja adicionar outra tarefa? (s/n): ");
    String resposta = stdin.readLineSync()?.toLowerCase() ?? "n";
    if (resposta != 's') {
      adicionarMais = false;
    }
  }
}

void calendario() {
  print("\nEscolha o número do mês (1-12): ");
  int calendarioMes = int.parse(stdin.readLineSync() ?? "0");

  List<TarefaEstudos> filtrar = organizar.where((c) => c.dataEntrega.month == calendarioMes).toList();

  if (filtrar.isEmpty) {
    print("Não há tarefas nesse mês.");
  } else {
    print("Tarefas do mês $calendarioMes:");
    filtrar.forEach((c) => c.exibirTarefas());
  }
}

void status() {
  print("\nEscolha Status (ATRASADO - CONCLUIDO - PENDENTE): ");
  String statusTarefa = stdin.readLineSync() ?? " ";

  List<TarefaEstudos> filtrar = organizar
      .where((c) => c.status.toLowerCase() == statusTarefa.toLowerCase())
      .toList();

  if (filtrar.isEmpty) {
    print("Nenhuma tarefa com esse status.");
  } else {
    filtrar.forEach((c) => c.exibirTarefas());
  }
}

void prazo() {
  print("\nEscolha Prazo (CURTO - MEDIO - LONGO): ");
  String prazoTarefa = stdin.readLineSync() ?? " ";

  List<TarefaEstudos> filtrar = organizar
      .where((c) => c.prazo.toLowerCase() == prazoTarefa.toLowerCase())
      .toList();

  if (filtrar.isEmpty) {
    print("Nenhuma tarefa possui esse prazo.");
  } else {
    filtrar.forEach((c) => c.exibirTarefas());
  }
}

void kanban() {
  print("\nEscolha Kanban (FAZER - FAZENDO - FEITO): ");
  String metodologia = stdin.readLineSync() ?? " ";

  List<TarefaEstudos> filtrar = organizar
      .where((c) => c.kanban.toLowerCase() == metodologia.toLowerCase())
      .toList();

  if (filtrar.isEmpty) {
    print("Nenhuma tarefa com essa metodologia Kanban.");
  } else {
    filtrar.forEach((c) => c.exibirTarefas());
  }
}

void modificar() {
  if (organizar.isEmpty) {
    print("Não existe tarefa para modificar.");
    return;
  }

  print("\nEscolha o número da tarefa que deseja modificar:");
  for (int i = 0; i < organizar.length; i++) {
    print("$i: ${organizar[i].tarefa}");
  }

  int indice = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (indice < 0 || indice >= organizar.length) {
    print("Erro: Opção inválido.");
    return;
  }

  TarefaEstudos tarefa = organizar[indice];

  print("Escolha uma opção: ");
  print("\n1 - Editar");
  print("2 - Excluir");
  String escolha = stdin.readLineSync() ?? "";

  //Excluir
  if (escolha == "2") {
    print("Tem certeza que deseja excluir? (s/n): ");
    String confirmar = stdin.readLineSync()?.toLowerCase() ?? "n";

    if (confirmar == "s") {
      organizar.removeAt(indice);
      print("Tarefa removida com sucesso!");
    } else {
      print("Remoção cancelada.");
    }
    return;
  }

  //Editar
  if (escolha == "1") {

    print("Nova tarefa (${tarefa.tarefa}): ");
    String novoNome = stdin.readLineSync()!;
    if (novoNome.isNotEmpty) tarefa.tarefa = novoNome;

    print("Nova data (dd/mm/aaaa) atual ${tarefa.dataEntrega.day}/${tarefa.dataEntrega.month}/${tarefa.dataEntrega.year}: ");
    String novaData = stdin.readLineSync()!;
    if (novaData.isNotEmpty) {
      List<String> data = novaData.split("/");
      int dia = int.parse(data[0]);
      int mes = int.parse(data[1]);
      int ano = int.parse(data[2]);


      tarefa.dataEntrega = DateTime(ano, mes, dia, tarefa.dataEntrega.hour, tarefa.dataEntrega.minute);
    }

    print("Novo horário (HH:MM) atual ${tarefa.dataEntrega.hour}:${tarefa.dataEntrega.minute}: ");
    String novoHorario = stdin.readLineSync()!;
    if (novoHorario.isNotEmpty) {
      List<String> tempo = novoHorario.split(":");
      int hora = int.parse(tempo[0]);
      int minuto = int.parse(tempo[1]);

      tarefa.dataEntrega = DateTime(
        tarefa.dataEntrega.year,
        tarefa.dataEntrega.month,
        tarefa.dataEntrega.day,
        hora,
        minuto,
      );
    }

    print("Novo status (${tarefa.status}): ");
    String novoStatus = stdin.readLineSync()!;
    if (novoStatus.isNotEmpty) tarefa.status = novoStatus;

    print("Novo prazo (${tarefa.prazo}): ");
    String novoPrazo = stdin.readLineSync()!;
    if (novoPrazo.isNotEmpty) tarefa.prazo = novoPrazo;

    print("Novo Kanban (${tarefa.kanban}): ");
    String novoKanban = stdin.readLineSync()!;
    if (novoKanban.isNotEmpty) tarefa.kanban = novoKanban;

    print("\nTarefa alterada com sucesso!");
    print("Veja a tarefa alterada, abaixo:\n");
    tarefa.exibirTarefas();
    
    return;
  }

  print("Opção inválida.");
}


void menu() {
  bool seguindo = true;

  while (seguindo) {
    print("""
Menu de Estudos
__________________________
1 - Adicionar Tarefa
2 - Calendário
3 - Status
4 - Prazo
5 - Kanban
6 - Modificar
7 - Sair
__________________________
""");

    String escolher = stdin.readLineSync() ?? " ";

    switch (escolher) {
      case "1":
        tarefa();
        break;
      case "2":
        calendario();
        break;
      case "3":
        status();
        break;
      case "4":
        prazo();
        break;
      case "5":
        kanban();
        break;
      case "6":
        modificar();
        break;
      case "7":
        print("Saindo do programa...");
        seguindo = false;
        break;
      default:
        print("Opção inválida, tente novamente.");
    }
  }
}

void main() {
  print("""
/*******************************************
*                                         *
*              PROJETO DART               *
*         GERENCIAMENTO DE ESTUDOS        *
*                                         *
********************************************/
""");

  menu();
}
