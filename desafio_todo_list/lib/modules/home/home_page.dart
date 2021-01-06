import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:todo_list_sqlite/modules/home/home_controller.dart';
import 'package:todo_list_sqlite/modules/new_task/new_task_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
        builder: (BuildContext contextConsumer, HomeController controller, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Atividades',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: FFNavigationBar(
          selectedIndex: controller.selectedTab,
          onSelectTab: (index) => controller.changeSelectedTab(context, index),
          items: [
            FFNavigationBarItem(
              //animationDuration: Duration(milliseconds: 500),
              iconData: Icons.check_circle_rounded,
              label: 'Finalizados',
            ),
            FFNavigationBarItem(
              //animationDuration: Duration(milliseconds: 10),
              iconData: Icons.view_week_rounded,
              label: 'Semanal',
            ),
            FFNavigationBarItem(
              //animationDuration: Duration(milliseconds: 10),
              iconData: Icons.calendar_today_rounded,
              label: 'Selecionar Data',
            )
          ],
          theme: FFNavigationBarTheme(
            itemWidth: 60,
            barHeight: 70,
            barBackgroundColor: Theme.of(context).primaryColor,
            //showSelectedItemShadow: false,
            selectedItemBackgroundColor: Theme.of(context).primaryColor,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
            selectedItemTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              //shadows: <Shadow>[Shadow(offset: Offset(6, 7), blurRadius: 4, color: Colors.black)],
            ),
            selectedItemBorderColor: Colors.white,
            //unselectedItemBackgroundColor: Theme.of(context).primaryColor,
            unselectedItemIconColor: Colors.white,
            unselectedItemLabelColor: Colors.white,
            unselectedItemTextStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          //color: Color(0xFF00b140),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            strokeWidth: 3,
            backgroundColor: Theme.of(context).primaryColor,
            color: Colors.white,
            onRefresh: () =>
                Future.delayed(Duration.zero, () => controller.update()),
            child: ListView.builder(
              itemCount: controller.listTodos?.keys?.length ?? 0,
              itemBuilder: (_, index) {
                var dateFormat = DateFormat('dd/MM/yyyy');
                var listTodos = controller.listTodos;
                var daykey = controller.listTodos.keys.elementAt(index);
                var day = daykey;
                var todos = listTodos[daykey];

                if (todos.isEmpty && controller.selectedTab == 0) {
                  return SizedBox.shrink();
                }

                var today = DateTime.now();
                if (daykey == dateFormat.format(today)) {
                  day = 'HOJE';
                } else if (daykey ==
                    dateFormat.format(today.add(Duration(days: 1)))) {
                  day = 'AMANHA';
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async => {
                              await Navigator.of(context).pushNamed(
                                  NewTaskPage.routerName,
                                  arguments: daykey),
                              controller.update(),
                            },
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (_, index) {
                        var todo = todos[index];
                        return Dismissible(
                          key: Key(todo.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => controller.deleteTodo(todo),
                          confirmDismiss: (_) => _buildConfirmDismiss(context),
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Theme.of(context).primaryColor,
                            child: Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              //splashRadius: 30,
                              //checkColor: Colors.black,
                              activeColor: Theme.of(context).primaryColor,
                              value: todo.finalizado,
                              onChanged: (bool value) =>
                                  controller.checkedOrUncheck(todo),
                            ),
                            title: Text(
                              todo.descricao,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: todo.finalizado
                                    ? TextDecoration.lineThrough
                                    //: TextDecoration.none,
                                    : null,
                              ),
                            ),
                            trailing: Text(
                              '${todo.dataHora.hour.toString().padLeft(2, '0')}:${todo.dataHora.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: todo.finalizado
                                    ? TextDecoration.lineThrough
                                    //: TextDecoration.none,
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Future<bool> _buildConfirmDismiss(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Apagar!!!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            content: const Text(
              'Confirma a exclusão ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Icon(
                  Icons.check,
                  size: 50,
                  color: Colors.white,
                ),
                // child: const Text(
                //   'CONFIRMAR',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //     fontSize: 20,
                //   ),
                // ),
              ),
              SizedBox(
                width: 90,
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Icon(
                  Icons.cancel,
                  size: 50,
                  color: Colors.white,
                ),
                // child: const Text(
                //   'CANCELAR',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //     fontSize: 20,
                //   ),
                // ),
              ),
            ],
          );
        });
  }
}
