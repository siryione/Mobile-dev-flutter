import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key key,
    @required this.text,
    @required this.onChanged,
    @required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
            return Container(
              height: 39,
              margin: EdgeInsets.only(left: 24, right: 24, top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[100],
              ),
              child: Stack(
                children: <Widget>[
                  TextField(
                    controller: controller,
                    onChanged: widget.onChanged,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16, right: 48, bottom: 8),
                      border: InputBorder.none,
                      hintText: 'Search movie...',
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      )
                    ),
                    
                  ),
                  // Positioned(
                  //   right: 0,
                  //   child: SvgPicture.asset('assets/svg/search.svg'),
                  //   )
                ],
              ),
            );
  }
}