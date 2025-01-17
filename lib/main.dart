import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ale App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AleApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isExpanded = false; // Para controlar el estado del menú desplegable
  int _selectedIndex = 0; // Para controlar el índice del menú inferior
  String _displayText = 'aleApp'; // Texto a mostrar debajo de "aleApp"

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia el índice seleccionado
      // Cambia el texto mostrado según la opción seleccionada
      if (index == 1) {
        _displayText =
            'Busca en Ale App'; // Cambia el texto a "Busca en Ale App"
      } else if (index == 2) {
        _displayText =
            'Configuración en Ale App'; // Cambia el texto a "Configuración en Ale App"
      } else {
        _displayText =
            'aleApp'; // Restablece el texto a "aleApp" para otras opciones
      }
    });
  }

  void _onDrawerItemTapped(String text) {
    setState(() {
      _displayText = text; // Cambia el texto mostrado
      _isExpanded = false; // Cierra el menú desplegable si está abierto
      Navigator.pop(context); // Cierra el menú
    });
  }

  void _showSearchDialog() {
    // Configuración del AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmar Búsqueda"),
      content: Text("¿Quieres buscar?"),
      actions: [
        TextButton(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
        ),
        TextButton(
          child: Text("Sí"),
          onPressed: () {
            // Aquí puedes agregar la lógica para realizar la búsqueda
            Navigator.of(context).pop(); // Cierra el diálogo
            // Lógica de búsqueda aquí
          },
        ),
      ],
    );

    // Mostrar el diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'aleApp',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Agregar la imagen de Internet
            CachedNetworkImage(
              imageUrl: 'https://via.placeholder.com/150', // URL de la imagen
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 20),
            Text(
              _displayText,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            // Agregar el botón de búsqueda
            if (_selectedIndex ==
                1) // Solo mostrar el botón si "Buscar" está seleccionado
              ElevatedButton(
                onPressed:
                    _showSearchDialog, // Mostrar el AlertDialog al presionar el botón
                child: const Text('Buscar'),
              ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.apps,
                    size: 50,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ale App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Opción 1'),
              onTap: () {
                _onDrawerItemTapped('Opción 1'); // Cambia el texto a "Opción 1"
              },
            ),
            ListTile(
              title: const Text('Opción 2'),
              onTap: () {
                _onDrawerItemTapped('Opción 2'); // Cambia el texto a "Opción 2"
              },
            ),
            ListTile(
              title: const Text('Opción 3'),
              onTap: () {
                setState(() {
                  _isExpanded =
                      !_isExpanded; // Cambia el estado del menú desplegable
                });
              },
              trailing: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
            // Menú desplegable para Opción 3
            if (_isExpanded) ...[
              ListTile(
                title: const Text('Desplegable 1'),
                onTap: () {
                  _onDrawerItemTapped(
                      'Desplegable 1'); // Cambia el texto a "Desplegable 1"
                },
              ),
              ListTile(
                title: const Text('Desplegable 2'),
                onTap: () {
                  _onDrawerItemTapped(
                      'Desplegable 2'); // Cambia el texto a "Desplegable 2"
                },
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ale',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
