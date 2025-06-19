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
        title: 'Productos App',
        theme: CupertinoThemeData(
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
          primaryColor: CupertinoColors.systemBlue,
          scaffoldBackgroundColor: _isDarkMode 
            ? CupertinoColors.black 
            : CupertinoColors.systemGroupedBackground,
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
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider?.isDarkMode ?? false;

    return CupertinoPageScaffold(
      backgroundColor: isDarkMode 
        ? CupertinoColors.black 
        : CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Icon with gradient background
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CupertinoColors.systemBlue,
                      CupertinoColors.systemPurple,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  CupertinoIcons.person_circle_fill,
                  size: 80,
                  color: CupertinoColors.white,
                ),
              ),
              const SizedBox(height: 50),
              
              // Welcome text
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Inicia sesión para continuar',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 40),
              
              // Email field with improved styling
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoTextField(
                  controller: _emailController,
                  placeholder: 'Correo electrónico',
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode 
                      ? CupertinoColors.systemGrey6.darkColor 
                      : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: CupertinoColors.systemGrey4,
                      width: 0.5,
                    ),
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(
                      CupertinoIcons.mail,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20),
              
              // Password field with improved styling
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoTextField(
                  controller: _passwordController,
                  placeholder: 'Contraseña',
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode 
                      ? CupertinoColors.systemGrey6.darkColor 
                      : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: CupertinoColors.systemGrey4,
                      width: 0.5,
                    ),
                  ),
                  obscureText: true,
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(
                      CupertinoIcons.lock,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Enhanced login button
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      CupertinoColors.systemBlue,
                      CupertinoColors.systemBlue.darkColor,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemBlue.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (context) => const MenuView()),
                    );
                  },
                ),
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
        backgroundColor: CupertinoColors.systemBackground,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            activeIcon: Icon(CupertinoIcons.add_circled_solid),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
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

// Home View - Product List with enhanced design
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<Map<String, dynamic>> products = const [
    {'name': 'iPhone 15 Pro', 'price': '\$999', 'date': '2024-01-15', 'icon': CupertinoIcons.phone, 'color': CupertinoColors.systemBlue},
    {'name': 'MacBook Pro M3', 'price': '\$2,499', 'date': '2024-01-10', 'icon': CupertinoIcons.desktopcomputer, 'color': CupertinoColors.systemGrey},
    {'name': 'iPad Air', 'price': '\$599', 'date': '2024-01-08', 'icon': CupertinoIcons.rectangle, 'color': CupertinoColors.systemPurple},
    {'name': 'Apple Watch Ultra', 'price': '\$799', 'date': '2024-01-05', 'icon': CupertinoIcons.clock, 'color': CupertinoColors.systemOrange},
    {'name': 'AirPods Pro', 'price': '\$249', 'date': '2024-01-03', 'icon': CupertinoIcons.headphones, 'color': CupertinoColors.systemGreen},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Productos',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: CupertinoColors.systemBackground,
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CupertinoListTile(
                padding: const EdgeInsets.all(16),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: product['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    product['icon'],
                    color: product['color'],
                    size: 28,
                  ),
                ),
                title: Text(
                  product['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'Registrado: ${product['date']}',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey2,
                    fontSize: 14,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product['price']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemGreen,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      color: CupertinoColors.systemGrey3,
                      size: 16,
                    ),
                  ],
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

// Enhanced Profile View
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider?.isDarkMode ?? false;
    final onThemeToggle = themeProvider?.toggleTheme ?? () {};

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              
              // Profile header with gradient
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CupertinoColors.systemBlue.withOpacity(0.1),
                      CupertinoColors.systemPurple.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          colors: [
                            CupertinoColors.systemBlue,
                            CupertinoColors.systemPurple,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemBlue.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        CupertinoIcons.person_fill,
                        size: 60,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Usuario Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'usuario@demo.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Settings section
              CupertinoListSection.insetGrouped(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CupertinoListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.person,
                        color: CupertinoColors.systemBlue,
                        size: 20,
                      ),
                    ),
                    title: const Text('Editar Perfil'),
                    trailing: const Icon(CupertinoIcons.forward),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDarkMode 
                          ? CupertinoColors.systemYellow.withOpacity(0.2)
                          : CupertinoColors.systemOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isDarkMode ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill,
                        color: isDarkMode ? CupertinoColors.systemYellow : CupertinoColors.systemOrange,
                        size: 20,
                      ),
                    ),
                    title: const Text('Modo Oscuro'),
                    trailing: CupertinoSwitch(
                      value: isDarkMode,
                      onChanged: (value) => onThemeToggle(),
                    ),
                  ),
                  CupertinoListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.settings,
                        color: CupertinoColors.systemGrey,
                        size: 20,
                      ),
                    ),
                    title: const Text('Configuración'),
                    trailing: const Icon(CupertinoIcons.forward),
                    onTap: () {},
                  ),
                  CupertinoListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.info,
                        color: CupertinoColors.systemPurple,
                        size: 20,
                      ),
                    ),
                    title: const Text('Acerca de'),
                    trailing: const Icon(CupertinoIcons.forward),
                    onTap: () {},
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Logout section
              CupertinoListSection.insetGrouped(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CupertinoListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.square_arrow_right,
                        color: CupertinoColors.systemRed,
                        size: 20,
                      ),
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
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Enhanced Product Registration View
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
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey3,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: _selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => _selectedDate = newDate);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final isDarkMode = themeProvider?.isDarkMode ?? false;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Registro de Productos',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        CupertinoColors.systemGreen,
                        CupertinoColors.systemBlue,
                      ],
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.add_circled_solid,
                    size: 40,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              const Center(
                child: Text(
                  'Nuevo Producto',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Form fields with enhanced styling
              _buildTextField(
                controller: _nameController,
                placeholder: 'Nombre del producto',
                icon: CupertinoIcons.cube_box,
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _priceController,
                placeholder: 'Precio (\$)',
                icon: CupertinoIcons.money_dollar,
                keyboardType: TextInputType.number,
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _descriptionController,
                placeholder: 'Descripción del producto',
                icon: CupertinoIcons.text_alignleft,
                maxLines: 4,
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 20),
              
              // Date selector with enhanced design
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode 
                    ? CupertinoColors.systemGrey6.darkColor 
                    : CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.calendar,
                        color: CupertinoColors.systemBlue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fecha de registro',
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        CupertinoIcons.chevron_down,
                        color: CupertinoColors.systemGrey,
                      ),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              // Action buttons with enhanced design
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: CupertinoColors.systemGrey4,
                          width: 1,
                        ),
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text('Cancelar'),
                        onPressed: () {
                          _nameController.clear();
                          _priceController.clear();
                          _descriptionController.clear();
                          setState(() => _selectedDate = DateTime.now());
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            CupertinoColors.systemGreen,
                            CupertinoColors.systemGreen.darkColor,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGreen.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text(
                          'Guardar',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('✅ Producto Guardado'),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        padding: const EdgeInsets.all(16),
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: BoxDecoration(
          color: isDarkMode 
            ? CupertinoColors.systemGrey6.darkColor 
            : CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
        prefix: Padding(
          padding: EdgeInsets.only(left: 12.0, top: maxLines > 1 ? 12.0 : 0),
          child: Icon(
            icon,
            color: CupertinoColors.systemBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
