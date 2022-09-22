// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_laravel_mysql_app/models/emp_model.dart';
import 'package:flutter_laravel_mysql_app/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Crud {
  Crud({
    this.emps,
    this.isUpdateButtonDisable,
  });

  final bool? isUpdateButtonDisable;
  final List<EmpModel>? emps;
}

class CrudNotifier extends StateNotifier<Crud> {
  CrudNotifier()
      : super(Crud(
          emps: [],
          isUpdateButtonDisable: true,
        )) {
    initAll();
  }

  TextEditingController? firstname;
  TextEditingController? lastname;
  EmpModel? emp;

  initAll() {
    firstname = TextEditingController();
    lastname = TextEditingController();
    fetchData();
  }

  void addEmp(BuildContext context) {
    if (firstname!.text.isEmpty || lastname!.text.isEmpty) {
      showSnackBar(context, "Text feild can't empty");
    } else {
      Services.addEmp(firstname!.text, lastname!.text).then((result) {
        print(result);
        if ('success' == result) {
          showSnackBar(context, "Add Emp");
          clear();
          fetchData();

          updatewith(isUpdateButtonDisable: true);
        }
      });
    }
  }

  void clear() {
    firstname!.text = "";
    lastname!.text = "";
  }

  void buttonDisble() {
    updatewith(isUpdateButtonDisable: false);
  }

  void fetchData() {

    Services.fetchData().then((emps) {
      return updatewith(emps: emps);
    });
  }

  deleteEmp(EmpModel emp, BuildContext context) {
    Services.deleteEmp(emp.id!).then((result) {
      if ('success' == result) {
        showSnackBar(context, "Delete Emp");
        clear();
        fetchData();
      }
    });
  }

  void updateEmp(EmpModel emp, BuildContext context) {
    if (firstname!.text.isEmpty || lastname!.text.isEmpty) {
      showSnackBar(context, "Text feild can't empty");
    } else {
      Services.updateEmp(emp.id!, firstname!.text, lastname!.text)
          .then((result) {
        if ('success' == result) {
          updatewith(isUpdateButtonDisable: true);
          showSnackBar(context, "Update Emp");
          fetchData();
          clear();
        }
      });
    }
  }

  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message),
    ));
  }

  void showUpdateText(EmpModel emp) {
    firstname!.text = emp.firstname!;
    lastname!.text = emp.lastname!;
  }

  updatewith({
    bool? isUpdateButtonDisable,
    List<EmpModel>? emps,
  }) {
    state = Crud(
      isUpdateButtonDisable:
          isUpdateButtonDisable ?? state.isUpdateButtonDisable,
      emps: emps ?? state.emps,
    );
  }
}
