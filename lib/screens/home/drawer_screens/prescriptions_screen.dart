import 'package:flutter/material.dart';
import 'package:ivrapp/screens/home/drawer_screens/services/DrawerServices.dart';

import '../../../constants.dart';
import '../../../model/prescription.dart';
import '../../../pick_file.dart';
import '../../../widgets/showAlert.dart';
import '../../crop_image/crop_image_screen.dart';

class PrescriptionScreen extends StatefulWidget {
  static const routeName = '/prescriptions-screen';
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  List<Prescription> prescriptions = [];
  bool isLoading = false;
  Map<String, dynamic>? filedetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getpres();
  }

  Future<void> getpres() async {
    prescriptions =
        await DrawerServices().getUserPrescriptions(context: context);
    await Future.delayed(Duration(seconds: 3));
  }

  void getCroppedImage() async {
    filedetails = await Pickfile().cropImage(context: context);

    Navigator.pushNamed(context, CropImageScreen.routeName,
        arguments: filedetails!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Prescriptions',
          style: TextStyle(color: whiteColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //getCroppedImage();
          showAlert(context: context, title: '', callback: getCroppedImage);
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: getpres(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: greenColor,
              ));
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.error == null) {
              return PrescriptionGrid(prescriptions: prescriptions);
            } else {
              return Text('Error. Please retry later');
            }
          }),
    );
  }
}

class PrescriptionGrid extends StatelessWidget {
  const PrescriptionGrid({super.key, required this.prescriptions});
  final List<Prescription> prescriptions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return PrescriptionTile(prescription: prescriptions[index]);
        },
        itemCount: prescriptions.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 49 / 51),
      ),
    );
  }
}

class PrescriptionTile extends StatelessWidget {
  const PrescriptionTile({
    super.key,
    required this.prescription,
  });

  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Image.network(
            prescription.prescriptionUrl,
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
