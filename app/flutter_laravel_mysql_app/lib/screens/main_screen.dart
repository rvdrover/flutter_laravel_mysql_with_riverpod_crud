import 'package:flutter/material.dart';
import 'package:flutter_laravel_mysql_app/providers/crud_provider.dart';
import 'package:flutter_laravel_mysql_app/widgets/custom_button.dart';
import 'package:flutter_laravel_mysql_app/widgets/custom_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crudNotifier = ref.watch(crudProvider.notifier);
    final crud = ref.watch(crudProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(child: Text("Flutter Laravel Mysql Crud")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "Enter Emp details",
                      style: TextStyle(fontSize: 40, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                CustomTxtFeild(
                  controller: crudNotifier.firstname!,
                  hint: "First Name",
                  lable: 'First Name',
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTxtFeild(
                  controller: crudNotifier.lastname!,
                  hint: "Last Name",
                  lable: 'Last Name',
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () => crudNotifier.addEmp(context),
                      child: const Text("ADD"),
                    ),
                    CustomButton(
                      onPressed: () {
                        if (crud.isUpdateButtonDisable == true) {
                          crudNotifier.showSnackBar(
                              context, "Please click emp field to update");
                        } else {
                          crudNotifier.updateEmp(
                              crudNotifier.emp!, context);
                        }
                      },
                      child: const Text("UPDATE"),
                    ),
                    CustomButton(
                      onPressed: () => crudNotifier.clear(),
                      child: const Text("CLEAR"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: crud.emps!.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                          "${crud.emps![index].firstname} ${crud.emps![index].lastname}"),
                      leading: Text(crud.emps![index].id.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          crudNotifier.deleteEmp(
                              crud.emps![index], context);
                        },
                      ),
                      onTap: () {
                        crudNotifier.buttonDisble();
                        crudNotifier.showUpdateText(crud.emps![index]);
                        crudNotifier.emp = crud.emps![index];
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
