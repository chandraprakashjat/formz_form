
1. What is FocusNode?

FocusNode object help to set focus or remove focus on EditController(TextField or TextFormField) by using FocusScope object.

2. What is the FocusScope?
   The Instance of FocusScope created automatically.
   Once user called FocusScope.of(context) it would search near by FocusScope instance to set focus on specific EditController by passing FocusNode instance which releated to any EditController.
  


3. How we hid keyboard on screenClick?

  FocusManager.instance.primaryFocus?.unFocus()


4. How we request focus on specific TextField?

   Step 1:- Ceate Focus Node :- FocusNode _node = FocusNode();

   Step 2:- Assign _focusNode to TextFormField or TextField focusNode

   Step 3:- FocusScope.of(context).requestFocus(_node);

5. How we hide keyboard on button click or Screen Route?

   Way 1:- FocusScope.of(context).requestFocus(new FocusNode())

   Way 2 :- FocusManager.instance.primaruFocus?.unFocus()