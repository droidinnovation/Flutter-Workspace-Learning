import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black54),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({super.key});

  @override
  Widget build(BuildContext context) {
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).

    var cart = context.watch<CartModel>();

    var itemStyle = Theme.of(context).textTheme.titleLarge;

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder:
          (context, index) => ListTile(
            leading: const Icon(Icons.done),
            trailing: IconButton(
              onPressed: () {
                cart.remove(cart.items[index]);
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
            title: Text(
              cart.items[index].name,
              style: itemStyle,
            ),
          ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal();

  @override
  Widget build(BuildContext context) {
    var hugeTextStyle = Theme.of(
      context,
    ).textTheme.displayLarge?.copyWith(fontSize: 42);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
              builder:
                  (context, cart, child) =>
                      Text('\$${cart.totalPrice}', style: hugeTextStyle),
            ),

            const SizedBox(width: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Buying has not support yet!'),
                  ),
                );
              },
              child: const Text('BUY!!!'),
            ),
          ],
        ),
      ),
    );
  }
}
