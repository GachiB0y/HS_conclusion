import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_conclusion/src/feature/conclusion/bloc/conclusion_barcode_bloc.dart';
import 'package:hs_conclusion/src/feature/initialization/widget/dependencies_scope.dart';

class ConclusionScreen extends StatefulWidget {
  const ConclusionScreen({
    super.key,
  });

  @override
  State<ConclusionScreen> createState() => _ConclusionScreenState();
}

class _ConclusionScreenState extends State<ConclusionScreen> {
  final _textController = TextEditingController();

  final _focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  late final ConclusionBarcodeBLoC conclusionBarcodeBLoC;
  @override
  void initState() {
    super.initState();
    conclusionBarcodeBLoC = ConclusionBarcodeBLoC(
      repository: DependenciesScope.of(context).conclusionRepository,
    )..add(const ConclusionBarcodeEvent.fetchBarcodesConclusion());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ConclusionBarcodeBLoC, ConclusionBarcodeState>(
        bloc: conclusionBarcodeBLoC,
        builder: (context, state) => Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (state.data != null && state.data!.isNotEmpty) {
                      conclusionBarcodeBLoC.add(
                        const ConclusionBarcodeEvent.sendBarcodeConclusion(),
                      );
                      print('SEND');
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Отправить"),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Отсканируйте ШК для ввывода из оборота',
                ),
                TextFormField(
                  controller: _textController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  validator: (value) {
                    FocusScope.of(context).requestFocus(
                      _focusNode,
                    ); // Установить фокус на TextFormField
                    if (value == null || value.isEmpty) {
                      return 'Значение обязательно';
                    }

                    if (state.data!.contains(value)) {
                      return 'ШК дублируется';
                    }

                    if ((!value.startsWith('1') || !value.startsWith('0')) &&
                        value.length < 18) {
                      return 'ШК паллета или коробки начианется с 0 или 1';
                    }

                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      conclusionBarcodeBLoC
                          .add(ConclusionBarcodeEvent.create(barcode: value));
                      print('GOOD');
                    }
                    _textController.clear();
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Кол-во ШК: ${state.data!.length}'),
                const Text('Список ШК на ввывод из оборота:'),
                const SizedBox(
                  height: 5,
                ),
                if (state is ConclusionBarcodeState$Processing)
                  const Column(
                    children: [
                      Text('Идет отправка данных...'),
                      CircularProgressIndicator.adaptive(),
                    ],
                  )
                else if (state.data!.isEmpty)
                  const Text('Нет данных')
                else
                  ListBarcodeWidget(
                    barcodes: state.data!,
                  ),
              ],
            ),
          ),
        ),
      );
}

class ListBarcodeWidget extends StatelessWidget {
  const ListBarcodeWidget({required this.barcodes, super.key});
  final List<String> barcodes;

  @override
  Widget build(BuildContext context) => Expanded(
        child: ListView.builder(
          // reverse: true,
          itemCount: barcodes.length,
          itemBuilder: (context, index) => Column(
            children: [
              Text(
                '${index + 1}  - ${barcodes[index]}',
              ),
              const Divider(),
            ],
          ),
        ),
      );
}
