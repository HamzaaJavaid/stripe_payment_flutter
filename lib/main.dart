import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stripe_payment_flutter/tracking-widget.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51NtSXsB9no9g424B9dFg90Raxah0XZ2BerhutcU2K8GOJFDdH25eTU1V1SHVdsiN76wWEtwdxr8KYaBDTUMAkQUb007y8nLQ2y";
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home : MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  tracking track = tracking();
  Map<String , dynamic>? publicIntent ;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(child: Column(
            children: [
              SizedBox(height: height/40,),
              track.track(),
              SizedBox(height: height/40,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                height: height/3,
                width: width/1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text('HAMZA JAVAID',style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.normal
                        ),)
                      ],
                    ),
                    SizedBox(height: height/180,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text('Account :- 53727xxxxxxx',style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                        ),)
                      ],
                    ),
                    SizedBox(height: height/20,),
                     Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Center(
                         child: Text('240.38',style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 52
                         ),),
                       ),
                       Text('\$',style: TextStyle(
                         color: Colors.greenAccent,
                         fontSize: 17
                       ),)
                     ],
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Available Funds',style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 13
                        ),)
                      ],
                    )
                  ],
                ),

              ),
              SizedBox(height: height/20,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                height: height/12,
                width: width/1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('ITEMS AMOUNT '),
                    Text(':'),
                    Text('80\$ ',style: TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),

              ),
              SizedBox(height: height/60,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                height: height/12,
                width: width/1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('TAX AMOUNT '),
                    Text(':'),
                    Text('8\$ ',style: TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),

              ),
              SizedBox(height: height/60,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                height: height/12,
                width: width/1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('TOTAL AMOUNT '),
                    Text(':'),
                    Text('88\$ ',style: TextStyle(
                      fontSize: 17,fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),

              ),
              SizedBox(height: height/20,),
              GestureDetector(
                onTap: (){

                   makePayment();

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  height: height/10,
                  width: width/1.1,
                  child: Center(child: Text('Proceed to Payment',style: TextStyle(
                      color: Colors.white,fontSize: 22
                  ),), ),
                ),
              )

            ],
          ),),
        ),
      ),
    );
  }

  Future<void> makePayment ()async{

   try{
     publicIntent = await createPayment('88','USD');
     await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
         paymentIntentClientSecret: publicIntent!['client_secret'],
         style: ThemeMode.dark,
         merchantDisplayName: "Hamzah Jaweid"
     ));
     displayPaymentSheet();
   }
       catch(e){
     print(e.toString());
       }
  }



  displayPaymentSheet()async{

    try{
      await Stripe.instance.presentPaymentSheet().then((value) {
        publicIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    }
        catch(e){
      print(e.toString());
        }
  }


  calculateAmount(String amount){
    int amounnt = int.parse(amount)*100;
    return amounnt.toString();
  }

  createPayment(String amount , String currency)async{
    try{

      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: {
        'amount':calculateAmount(amount),
          'currency':currency,
          'payment_method_types[]':'card'
        },
        headers: {
        'Authorization':'Bearer sk_test_51NtSXsB9no9g424BQVzhrwzP3zBbTkWfRyEdU34GME6F5wZKKNVsvkMO8iNfVv2WVRpKIowfPt0AZG7AGqRRsNNA00G5Z2Lzeb',
          "Content-Type":"application/x-www-form-urlencoded"
        }
      );
      return jsonDecode(response.body.toString());

    }
        catch(e){
      print(e.toString());
        }
  }


}






