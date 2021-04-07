import 'package:flutter/material.dart';
import 'package:shop_cart/cart.dart';
import 'package:shop_cart/dish_object.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: deprecated_member_use
  List<Dish> _dishes = List<Dish>();
  // ignore: deprecated_member_use
  List<Dish> _cartList = List<Dish>();

  @override
  void initState() {
    _populateDishes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Order"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 25.0),
                  if (_cartList.length > 0)
                    Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              onTap: () {
                if (_cartList.isNotEmpty)
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Cart(_cartList)));
              },
            ),
          )
        ],
      ),
      body: _buildGridView(),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          var item = _dishes[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Card(
              elevation: 4.0,
              child: ListTile(
                leading: Icon(
                  item.icon,
                  color: item.color,
                ),
                title: Text(item.name),
                trailing: GestureDetector(
                  child: (!_cartList.contains(item)
                      ? Icon(Icons.add_circle, color: Colors.green)
                      : Icon(Icons.remove_circle, color: Colors.red)),
                  onTap: () {
                    setState(() {
                      if (!_cartList.contains(item))
                        _cartList.add(item);
                      else
                        _cartList.remove(item);
                    });
                  },
                ),
              ),
            ),
          );
        });
  }

  GridView _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _dishes.length,
      itemBuilder: (context, index) {
        var item = _dishes[index];
        return Card(
          elevation: 4.0,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon,
                      color:
                          (_cartList.contains(item)) ? Colors.grey : item.color,
                      size: 100),
                  Text(item.name,
                      textAlign: TextAlign.center,
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.subhead),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 8, bottom: 8),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: (!_cartList.contains(item)) ? Icon(Icons.add_circle, color: Colors.green) : Icon(Icons.remove_circle, color: Colors.red),
                    onTap: (){
                      setState(() {
                        if(!_cartList.contains(item))_cartList.add(item);
                        else
                        _cartList.remove(item);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _populateDishes() {
    var list = <Dish>[
      Dish(
        name: 'Chicken Zinger',
        icon: Icons.fastfood,
        color: Colors.amber,
      ),
      Dish(
        name: 'Chicken Zinger without chicken',
        icon: Icons.print,
        color: Colors.deepOrange,
      ),
      Dish(
        name: 'Rice',
        icon: Icons.child_care,
        color: Colors.brown,
      ),
      Dish(
        name: 'Beef burger without beef',
        icon: Icons.whatshot,
        color: Colors.green,
      ),
      Dish(
        name: 'Laptop without OS',
        icon: Icons.laptop,
        color: Colors.purple,
      ),
      Dish(
        name: 'Mac wihout macOS',
        icon: Icons.laptop_mac,
        color: Colors.blueGrey,
      ),
    ];

    setState(() {
      _dishes = list;
    });
  }
}