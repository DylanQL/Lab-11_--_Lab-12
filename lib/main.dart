import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Theme Provider using InheritedWidget
class ThemeProvider extends InheritedWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ThemeProvider({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
    required super.child,
  });

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkMode: _isDarkMode,
      toggleTheme: _toggleTheme,
      child: CupertinoApp(
        title: 'Flutter Cupertino Demo',
        theme: CupertinoThemeData(
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
          primaryColor: CupertinoColors.systemBlue,
        ),
        home: const LoginView(),
      ),
    );
  }
}

// Login View
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Iniciar Sesión'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.person_circle,
                size: 100,
                color: CupertinoColors.systemBlue,
              ),
              const SizedBox(height: 40),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Correo electrónico',
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.mail),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Contraseña',
                obscureText: true,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.lock),
                ),
              ),
              const SizedBox(height: 40),
              CupertinoButton.filled(
                child: const Text('Iniciar Sesión'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => const MenuView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Menu View with Tab Navigation
class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Perfil',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomeView();
          case 1:
            return const ProductRegistrationView();
          case 2:
            return const ProfileView();
          default:
            return const HomeView();
        }
      },
    );
  }
}

// Home View - Product List
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<Map<String, String>> products = const [
    {'name': 'iPhone 15', 'price': '\$999', 'date': '2024-01-15'},
    {'name': 'MacBook Pro', 'price': '\$2,499', 'date': '2024-01-10'},
    {'name': 'iPad Air', 'price': '\$599', 'date': '2024-01-08'},
    {'name': 'Apple Watch', 'price': '\$399', 'date': '2024-01-05'},
    {'name': 'AirPods Pro', 'price': '\$249', 'date': '2024-01-03'},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Productos'),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.cube_box,
                  color: CupertinoColors.systemBlue,
                ),
                title: Text(product['name']!),
                subtitle: Text('Fecha: ${product['date']}'),
                trailing: Text(
                  product['price']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGreen,
                  ),
                ),
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text(product['name']!),
                      content: Text('Precio: ${product['price']}\nFecha: ${product['date']}'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('Cerrar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Profile View
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider?.isDarkMode ?? false;
    final onThemeToggle = themeProvider?.toggleTheme ?? () {};

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Perfil'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(
              CupertinoIcons.person_circle_fill,
              size: 120,
              color: CupertinoColors.systemBlue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Usuario Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'usuario@demo.com',
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
              ),
            ),
            const SizedBox(height: 40),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.person),
                  title: const Text('Editar Perfil'),
                  trailing: const Icon(CupertinoIcons.forward),
                  onTap: () {},
                ),
                CupertinoListTile(
                  leading: Icon(
                    isDarkMode ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill,
                    color: isDarkMode ? CupertinoColors.systemYellow : CupertinoColors.systemOrange,
                  ),
                  title: const Text('Modo Oscuro'),
                  trailing: CupertinoSwitch(
                    value: isDarkMode,
                    onChanged: (value) => onThemeToggle(),
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Configuración'),
                  trailing: const Icon(CupertinoIcons.forward),
                  onTap: () {},
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.info),
                  title: const Text('Acerca de'),
                  trailing: const Icon(CupertinoIcons.forward),
                  onTap: () {},
                ),
                CupertinoListTile(
                  leading: const Icon(
                    CupertinoIcons.square_arrow_right,
                    color: CupertinoColors.systemRed,
                  ),
                  title: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: CupertinoColors.systemRed),
                  ),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Cerrar Sesión'),
                        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('Cancelar'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text('Cerrar Sesión'),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(builder: (context) => const LoginView()),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Product Registration View
class ProductRegistrationView extends StatefulWidget {
  const ProductRegistrationView({super.key});

  @override
  State<ProductRegistrationView> createState() => _ProductRegistrationViewState();
}

class _ProductRegistrationViewState extends State<ProductRegistrationView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: _selectedDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDate) {
              setState(() => _selectedDate = newDate);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Registro de Productos'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Información del Producto',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Nombre del producto',
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.cube_box),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _priceController,
                placeholder: 'Precio',
                keyboardType: TextInputType.number,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(CupertinoIcons.money_dollar),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _descriptionController,
                placeholder: 'Descripción',
                maxLines: 3,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Icon(CupertinoIcons.text_alignleft),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fecha de registro'),
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                      child: const Icon(CupertinoIcons.calendar),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        _nameController.clear();
                        _priceController.clear();
                        _descriptionController.clear();
                        setState(() => _selectedDate = DateTime.now());
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CupertinoButton.filled(
                      child: const Text('Guardar'),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: const Text('Producto Guardado'),
                            content: const Text('El producto se ha registrado exitosamente.'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _nameController.clear();
                                  _priceController.clear();
                                  _descriptionController.clear();
                                  setState(() => _selectedDate = DateTime.now());
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
