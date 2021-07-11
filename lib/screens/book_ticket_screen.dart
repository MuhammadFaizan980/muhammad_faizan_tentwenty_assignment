import 'package:faizan_tentwenty_assignment/contracts/i_button_clicked.dart';
import 'package:faizan_tentwenty_assignment/contracts/i_ticket_booked.dart';
import 'package:faizan_tentwenty_assignment/enums/button_type.dart';
import 'package:faizan_tentwenty_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookTicketScreen extends StatefulWidget {
  ITicketBooked _iTicketBooked;
  int _movieId;

  BookTicketScreen(this._iTicketBooked, this._movieId);

  @override
  _BookTicketScreenState createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen>
    implements IButtonClicked {
  late List<String> _locations;
  late List<String> _cinemas;
  late List<String> _seats;
  late String _selectedLocation;
  late String _selectedCinema;
  late String _selectedSeat;

  @override
  void initState() {
    _locations = ['Islamabad', 'Rawalpindi', 'Karachi'];
    _cinemas = ['Cinema A', 'Cinema B', 'Cinema C'];
    _seats = ['Seat A', 'Seat B', 'Seat C'];
    _selectedLocation = _locations[0];
    _selectedCinema = _cinemas[0];
    _selectedSeat = _seats[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Movie Ticket'),
      ),
      backgroundColor: Color(0xfff7f7f7),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _getDropDown(
                _locations,
                0,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Select Cinema',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _getDropDown(
                _cinemas,
                1,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Select Seat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              _getDropDown(
                _seats,
                2,
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: Utils.getOutlinedButton(
                      'Book Now',
                      this,
                      ButtonType.ADD_TICKET,
                      color: Colors.blue,
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

  Widget _getDropDown(List<String> itemsList, int index) {
    return DropdownButton(
      isExpanded: true,
      value: index == 0
          ? _selectedLocation
          : index == 1
              ? _selectedCinema
              : _selectedSeat,
      onChanged: (val) {
        if (index == 0) _selectedLocation = val.toString();
        if (index == 1) _selectedCinema = val.toString();
        if (index == 2) _selectedSeat = val.toString();
        setState(() {});
      },
      items: itemsList
          .map(
            (e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ),
          )
          .toList(),
    );
  }

  @override
  void onButtonClicked(ButtonType buttonType) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt(widget._movieId.toString(), widget._movieId);
    Utils.showSnackBar(context, 'Ticket Booked');
    widget._iTicketBooked.onTicketBooked();
    Navigator.pop(context);
  }
}
