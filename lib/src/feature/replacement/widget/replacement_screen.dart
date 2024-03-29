import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_conclusion/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:hs_conclusion/src/feature/replacement/bloc/replacement_bloc/replacement_bloc.dart';
import 'package:hs_conclusion/src/feature/replacement/bloc/replacement_view_model_bloc/replacement_view_model_bloc.dart';
import 'package:hs_conclusion/src/feature/replacement/model/pallet_model.dart';
import 'package:hs_conclusion/src/feature/replacement/widget/replacment_scope.dart';

class ReplacementScreen extends StatefulWidget {
  const ReplacementScreen({super.key});

  @override
  State<ReplacementScreen> createState() => _ReplacementScreenState();
}

class _ReplacementScreenState extends State<ReplacementScreen> {
  late final ReplacementBLoC replacementBloc;
  late final ReplacementViewModelBLoC viewModelBLoC;
  int count = 0;
  List<Item> items = [];
  @override
  void initState() {
    super.initState();

    replacementBloc = ReplacementBLoC(
      repository: DependenciesScope.of(context).replacementRepository,
    )..add(const ReplacementEvent.getCash());
    viewModelBLoC = ReplacementViewModelBLoC(
      repository: DependenciesScope.of(context).replacementRepository,
    );
  }

  Future<void> showDaologChangeBarcodeParty(
    BuildContext context,
  ) {
    final textController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      barrierDismissible: false, //РАСКОМЕНТИРОВАТЬ В  РЕЛИЗЕ

      context: context,
      builder: (BuildContext context) => AlertDialog(
        elevation: 3.0,
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Отсканируйте штрихкод',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    textController.clear();
                    FocusScope.of(context).requestFocus(
                      focusNode,
                    ); // Установить фокус на TextFormField
                    return 'Значение обязательно';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text(
                'Подтвердить',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (textController.text.isNotEmpty) {
                    replacementBloc.add(
                      ReplacementEvent.fetch(barcode: textController.text),
                    );
                  }

                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showDialogAddBox(
    BuildContext context,
  ) {
    final textController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      barrierDismissible: false, //РАСКОМЕНТИРОВАТЬ В  РЕЛИЗЕ

      context: context,
      builder: (BuildContext context) => AlertDialog(
        elevation: 3.0,
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Отксанируйте ШК Коробки'),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Отсканируйте штрихкод',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    textController.clear();
                    FocusScope.of(context).requestFocus(
                      focusNode,
                    ); // Установить фокус на TextFormField
                    return 'Значение обязательно';
                  }
                  if (!value.startsWith('0')) {
                    textController.clear();
                    FocusScope.of(context).requestFocus(
                      focusNode,
                    ); // Установить фокус на TextFormField
                    return 'ШК должен начинаться с 0';
                  }
                  final isDuplicateBarcode =
                      ReplacmentScope.of(context).state.checkDuplicateBarcode(
                            replacementBloc.state.data!.boxes,
                            value,
                          );
                  if (isDuplicateBarcode) {
                    textController.clear();
                    FocusScope.of(context).requestFocus(
                      focusNode,
                    ); // Установить фокус на TextFormField
                    return 'ШК дублируется в Паллете';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {
                    if (textController.text.isNotEmpty) {
                      replacementBloc.add(
                        ReplacementEvent.create(barcode: textController.text),
                      );
                    }

                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ReplacementViewModelBLoC, ReplacementViewModelState>(
        bloc: viewModelBLoC,
        listener: (context, state) {
          if (state is ReplacementViewModelState$Successful &&
              state.data != null &&
              state.data!.isShowDialogAddBarcodesItems == true) {
            showDialogFillBox(
              context,
              replacementBloc.state.data!.boxes.length,
            );

            //TODO Неправильный индекс!
          }
        },
        child: BlocBuilder<ReplacementBLoC, ReplacementState>(
          bloc: replacementBloc,
          builder: (context, state) => Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (replacementBloc.state.data == null) {
                      return;
                    }
                    replacementBloc.add(const ReplacementEvent.sendPallet());
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Сохранить"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => showDaologChangeBarcodeParty(context),
                      icon: const Icon(Icons.search),
                      label: const Text("Поиск"),
                    ),
                    if (state.data != null)
                      ElevatedButton.icon(
                        onPressed: () => showDialogAddBox(context),
                        icon: const Icon(Icons.add),
                        label: const Text("Добавить коробку"),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                if (state is ReplacementState$Processing)
                  const Column(
                    children: [
                      Text('Идет отправка данных...'),
                      CircularProgressIndicator.adaptive(),
                    ],
                  )
                else if (state.data == null)
                  const Text('Нет данных')
                else
                  ListBarcodeWidget(
                    pallet: state.data!,
                    replacementBloc: replacementBloc,
                  ),
              ],
            ),
          ),
        ),
      );

  /// Show a dialog to add barcodes.
  Future<void> showDialogFillBox(
    BuildContext context,
    int indexBox,
  ) {
    final textController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      barrierDismissible: false, //РАСКОМЕНТИРОВАТЬ В  РЕЛИЗЕ

      context: context,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            elevation: 3.0,
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$count из ${replacementBloc.state.data!.countItemInBox.toString()}',
                  ),
                  TextFormField(
                    focusNode: focusNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Отсканируйте штрихкод',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        textController.clear();
                        FocusScope.of(context).requestFocus(
                          focusNode,
                        ); // Установить фокус на TextFormField
                        return 'Значение обязательно';
                      }
                      final isDuplicateBarcode = ReplacmentScope.of(context)
                          .state
                          .checkDuplicateBarcode(
                            replacementBloc.state.data!.boxes,
                            value,
                          );
                      if (isDuplicateBarcode) {
                        textController.clear();
                        FocusScope.of(context).requestFocus(
                          focusNode,
                        ); // Установить фокус на TextFormField
                        return 'ШК дублируется в Паллете';
                      }

                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          count++;
                          items.add(
                            Item(barcode: value),
                          );
                        });

                        if (count ==
                            replacementBloc.state.data!.countItemInBox) {
                          replacementBloc.add(
                            ReplacementEvent.update(
                              indexBox: indexBox,
                              item: items,
                            ),
                          );
                          setState(() {
                            count = 0;
                            items = [];
                          });

                          Navigator.pop(context);
                        }
                      }

                      textController.clear();
                      FocusScope.of(context).requestFocus(
                        focusNode,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListBarcodeWidget extends StatefulWidget {
  const ListBarcodeWidget({
    required this.pallet,
    required this.replacementBloc,
    super.key,
  });
  final ModelsPallet pallet;
  final ReplacementBLoC replacementBloc;

  @override
  State<ListBarcodeWidget> createState() => _ListBarcodeWidgetState();
}

class _ListBarcodeWidgetState extends State<ListBarcodeWidget> {
  int count = 0;
  List<Item> items = [];

  /// Show a dialog to add barcodes.
  Future<void> showDialogAddBarcodes(
    BuildContext context,
    int indexBox,
  ) {
    final textController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      barrierDismissible: false, //РАСКОМЕНТИРОВАТЬ В  РЕЛИЗЕ

      context: context,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            elevation: 3.0,
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$count из ${widget.pallet.countItemInBox.toString()}'),
                  TextFormField(
                    focusNode: focusNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Отсканируйте штрихкод',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        textController.clear();
                        FocusScope.of(context).requestFocus(
                          focusNode,
                        ); // Установить фокус на TextFormField
                        return 'Значение обязательно';
                      }
                      final isDuplicateBarcode = ReplacmentScope.of(context)
                          .state
                          .checkDuplicateBarcode(
                            widget.pallet.boxes,
                            value,
                          );
                      if (isDuplicateBarcode) {
                        textController.clear();
                        FocusScope.of(context).requestFocus(
                          focusNode,
                        ); // Установить фокус на TextFormField
                        return 'ШК дублируется в Паллете';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          count++;
                          items.add(
                            Item(barcode: value),
                          );
                        });

                        if (count == widget.pallet.countItemInBox) {
                          widget.replacementBloc.add(
                            ReplacementEvent.update(
                              indexBox: indexBox,
                              item: items,
                            ),
                          );
                          setState(() {
                            count = 0;
                            items = [];
                          });

                          Navigator.pop(context);
                        }
                      }

                      textController.clear();
                      FocusScope.of(context).requestFocus(
                        focusNode,
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  child: const Text(
                    'Закрыть',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    showDialogDeleteBox(context, indexBox);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show a dialog box to confirm deletion with the provided context.
  Future<void> showDialogDeleteBox(
    BuildContext context,
    int indexBox,
  ) =>
      showDialog<void>(
        barrierDismissible: false, //РАСКОМЕНТИРОВАТЬ В  РЕЛИЗЕ

        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 3.0,
          content: const Text("Вы точно хотите удалить коробку?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Нет',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Да',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                widget.replacementBloc.add(
                  ReplacementEvent.delete(indexBox: indexBox),
                );
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final List<Widget> gropWidgetBox = [];

    for (var i = 0; i < widget.pallet.boxes.length; i++) {
      var indexItem = 0;
      final newWidget = ExpansionTile(
        title: Row(
          children: [
            Text('${i + 1}. ${widget.pallet.boxes[i].barcode}'),
            Expanded(
              child: IconButton(
                onPressed: () => showDialogAddBarcodes(context, i),
                icon: const Icon(Icons.edit),
              ),
            ),
          ],
        ),
        children: widget.pallet.boxes[i].items.map(
          (item) {
            indexItem++;
            return Text('Штука №${indexItem.toString()}');
          },
        ).toList(),
      );
      gropWidgetBox.add(newWidget);
    }
    return Expanded(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => ExpansionTile(
          title: Text(widget.pallet.barcode),
          children: gropWidgetBox,
        ),
      ),
    );
  }
}
