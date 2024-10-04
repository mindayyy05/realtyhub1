import 'dart:convert';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // Import for image picking
import 'package:shared_preferences/shared_preferences.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);


  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {

  final ImagePicker _picker = ImagePicker(); // Image picker instance
  List<XFile>? _selectedImages = []; // List for selected images

  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _garagesController = TextEditingController();
  final TextEditingController _landSizeController = TextEditingController();
  final TextEditingController _houseSizeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _pricePerSqFtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final List<String> _features = ['AC', 'TV', 'WiFi', 'Pool', 'Fireplace', 'Parking', 'Kitchen', 'Gym', 'Garden', 'Basement'];
  final Map<String, bool> _selectedFeatures = {};

  bool _isNegotiable = false;
  bool _isForSale = false;
  bool _isForRent = false;

  String? _selectedPropertyType;

  final List<String> _propertyTypes = [
    'House',
    'Apartment',
    'Room & Annex',
    'Commercial Property',
    'Rental Space',
    'Town House'
  ];

  String? _selectedRealEstateAgent;

  final List<String> _realestateAgents = [
    'Prime Realty Group',
    'Urban Nest Realty',
    'Elite Property Solutions',
    'Golden Key Real Estate',
    'Horizon Homes Agency',
    'Houses & co',
    'Other'
  ];


  String? _selectedState;

  final List<String> _states = [
    'Colombo',
    'Galle',
    'Jaffna',
    'Kandy',
    'Trincomalee',
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Gampaha',
    'Hambantota',
    'Kalutara',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Vavuniya',
  ];


  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        // Limit the number of selected images to 5
        if (_selectedImages!.length + images.length > 5) {
          // Show a dialog or a message if trying to select more than 5 images
          final excess = (_selectedImages!.length + images.length) - 5;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You can only select up to 5 images.'),
              backgroundColor: Colors.red,
            ),
          );
          _selectedImages = _selectedImages!.sublist(0, 5 - excess) + images.sublist(0, excess);
        } else {
          _selectedImages!.addAll(images);
        }
      });
    }
  }


  Future<void> listProperty(
      String bedrooms,
      String bathrooms,
      String garages,
      String land_size,
      String house_size,
      String price,
      String price_per_sqft,
      String address,
      String street_address,
      String city,
      String? state,
      String zip_code,
      String longitude,
      String latitude,
      String title,
      String description,
      String? real_estate_agent,
      String? property_type, // Include the property type here
      bool isNegotiable, // Add this parameter
      bool isForSale, // Add this parameter
      bool isForRent, // Add this parameter
      List<XFile>? images,

      ) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/sell');
      var request = http.MultipartRequest('POST', url);

      request.fields['bedrooms'] = bedrooms;
      request.fields['bathrooms'] = bathrooms;
      request.fields['garages'] = garages;
      request.fields['land_size'] = land_size;
      request.fields['house_size'] = house_size;
      request.fields['price'] = price;
      request.fields['price_per_sqft'] = price_per_sqft;
      request.fields['address'] = address;
      request.fields['street_address'] = street_address;
      request.fields['city'] = city;
      request.fields['state'] = state ?? '';
      request.fields['zip_code'] = zip_code;
      request.fields['longitude'] = longitude;
      request.fields['latitude'] = latitude;
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['real_estate_agent'] = real_estate_agent ?? '';
      request.fields['property_type'] = property_type ?? ''; // Add property type field
      request.fields['is_negotiable'] = isNegotiable ? '1' : '0'; // Set is_negotiable field
      request.fields['is_for_sale'] = isForSale ? '1' : '0';
      request.fields['is_for_rent'] = isForRent ? '1' : '0';

      // Mapping images to specific fields (image_1, image_2, etc.)
      // Handling images
      // Add images to request
      if (images != null && images.isNotEmpty) {
        for (int i = 0; i < images.length && i < 5; i++) {
          var stream = http.ByteStream(images[i].openRead());
          var length = await images[i].length();
          var multipartFile = http.MultipartFile(
            'images[]', // Array format to match Laravel's validation
            stream,
            length,
            filename: images[i].name,
          );
          request.files.add(multipartFile);
        }
      }



      var response = await request.send();
      if (response.statusCode == 200) {
        // Handle successful response
        print('Property listed successfully');
      } else {
        // Handle error
        print('Failed to list property');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _sell() {


    var bedrooms = _bedroomsController.text;
    var bathrooms = _bathroomsController.text;
    var garages = _garagesController.text;
    var land_size = _landSizeController.text;
    var house_size = _houseSizeController.text;
    var price = _priceController.text;
    var price_per_sqft = _pricePerSqFtController.text;
    var address = _addressController.text;
    var street_address = _streetAddressController.text;
    var city = _cityController.text;
    var state = _selectedState;
    var zip_code = _zipCodeController.text;
    var longitude = _longitudeController.text;
    var latitude = _latitudeController.text;
    var title = _titleController.text;
    var description = _descriptionController.text;
    var real_estate_agent = _selectedRealEstateAgent;
    var property_type = _selectedPropertyType; // Get the selected property type


    // Call the function to list the property
    listProperty(
      bedrooms,
      bathrooms,
      garages,
      land_size,
      house_size,
      price,
      price_per_sqft,
      address,
      street_address,
      city,
      state,
      zip_code,
      longitude,
      latitude,
      title,
      description,
      real_estate_agent,
      property_type, // Include property type here
      _isNegotiable, // Pass the isNegotiable value
      _isForSale,
      _isForRent,
      _selectedImages,
    );
  }

  @override
  void initState() {
    super.initState();
    for (var feature in _features) {
      _selectedFeatures[feature] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Your Property'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFcfd9df), Color(0xFFe2ebf0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Apply padding properly
          child: SingleChildScrollView(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Padding within the Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Property Information'),
                    const SizedBox(height: 20),
                    // Property Type Dropdown
                    _buildTextField(
                      'Property Type',
                      null,
                      Icons.home,
                      'Select Property Type',
                      isDropdown: true,
                      dropdownItems: _propertyTypes,
                      selectedValue: _selectedPropertyType,
                      onChanged: (value) {
                        setState(() {
                          _selectedPropertyType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Bedrooms', _bedroomsController, Icons.bed, 'Enter number of bedrooms'),
                    const SizedBox(height: 20),
                    _buildTextField('Bathrooms', _bathroomsController, Icons.bathtub, 'Enter number of bathrooms'),
                    const SizedBox(height: 20),
                    _buildTextField('Garages', _garagesController, Icons.garage, 'Enter number of garages'),
                    const SizedBox(height: 20),
                    _buildTextField('Land Size (sq ft)', _landSizeController, Icons.landscape, 'Enter land size in square feet'),
                    const SizedBox(height: 20),
                    _buildTextField('House Size (sq ft)', _houseSizeController, Icons.house, 'Enter house size in square feet'),
                    const SizedBox(height: 20),
                    _buildTextField('Price', _priceController, Icons.attach_money, 'Enter price'),
                    const SizedBox(height: 20),
                    _buildTextField('Price Per Sq Ft', _pricePerSqFtController, Icons.monetization_on, 'Enter price per square foot'),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Address Information'),
                    const SizedBox(height: 10),
                    _buildTextField('Address', _addressController, Icons.location_on, 'Enter property address'),
                    const SizedBox(height: 10),
                    _buildTextField('Street Address', _streetAddressController, Icons.streetview, 'Enter street address'),
                    const SizedBox(height: 10),
                    _buildTextField('City', _cityController, Icons.location_city, 'Enter city'),
                    const SizedBox(height: 20),
                    // Property Type Dropdown
                    _buildTextField(
                      'State',
                      null,
                      Icons.location_on,
                      'Select State',
                      isDropdown: true,
                      dropdownItems: _states,
                      selectedValue: _selectedState,
                      onChanged: (value) {
                        setState(() {
                          _selectedState = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField('Zip Code', _zipCodeController, Icons.code, 'Enter zip code'),
                    const SizedBox(height: 10),
                    _buildTextField('Latitude', _latitudeController, Icons.pin_drop, 'Enter latitude'),
                    const SizedBox(height: 10),
                    _buildTextField('Longitude', _longitudeController, Icons.pin_drop, 'Enter longitude'),
                    const SizedBox(height: 20),
                    _buildTextField('Title', _titleController, Icons.title, 'Enter listing title'),
                    const SizedBox(height: 20),
                    _buildTextField('Description', _descriptionController, Icons.description, 'Enter property description'),
                    const SizedBox(height: 20),
                    // Property Type Dropdown
                    _buildTextField(
                      'Real Estate Agent',
                      null,
                      Icons.person,
                      'Select Real Estate Agent',
                      isDropdown: true,
                      dropdownItems: _realestateAgents,
                      selectedValue: _selectedRealEstateAgent,
                      onChanged: (value) {
                        setState(() {
                          _selectedRealEstateAgent = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    _buildSectionTitle('Features'),
                    const SizedBox(height: 10),
                    _buildFeatureSelection(),
                    const SizedBox(height: 20),
                    // Negotiable Checkbox
                    CheckboxListTile(
                      title: const Text('Negotiable'),
                      value: _isNegotiable,
                      onChanged: (bool? value) {
                        setState(() {
                          _isNegotiable = value ?? false;
                        });
                      },
                    ),

                    const SizedBox(height: 20),
                    // for sale
                    CheckboxListTile(
                      title: const Text('For sale'),
                      value: _isForSale,
                      onChanged: (bool? value) {
                        setState(() {
                          _isForSale = value ?? false;
                        });
                      },
                    ),


                    const SizedBox(height: 20),
                    // for rent
                    CheckboxListTile(
                      title: const Text('For rent'),
                      value: _isForRent,
                      onChanged: (bool? value) {
                        setState(() {
                          _isForRent = value ?? false;
                        });
                      },
                    ),


                    const SizedBox(height: 20),

// Add an image picker section
                    _buildSectionTitle('Upload Images'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _pickImages, // Assuming this is your upload image function
                          child: const Text('Upload Image'),
                        ),
                        ElevatedButton(
                          onPressed: _takePhoto,
                          child: const Text('Take Photo'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _selectedImages != null && _selectedImages!.isNotEmpty
                        ? Wrap(
                      spacing: 10.0,
                      children: _selectedImages!.map((image) {
                        return Stack(
                          children: [
                            Image.file(
                              File(image.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _selectedImages!.remove(image);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                        : const Text('No images selected'),

                    const SizedBox(height: 10),
                    if (_selectedImages != null && _selectedImages!.length >= 5)
                      const Text(
                        'You can only select up to 5 images.',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _sell,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: Colors.blueAccent,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Center(child: Text('Submit')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          // Add the taken photo to the selected images list
          if (_selectedImages!.length < 5) {
            _selectedImages!.add(photo);
          } else {
            // Show a dialog or a message if trying to select more than 5 images
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You can only select up to 5 images.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      }
    } catch (e) {
      print('Error taking photo: $e');
    }
  }


  Widget _buildTextField(String label, TextEditingController? controller, IconData icon, String hintText,
      {bool isDropdown = false, List<String>? dropdownItems, String? selectedValue, ValueChanged<String?>? onChanged}) {
    return isDropdown
        ? DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      items: dropdownItems?.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    )
        : TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildFeatureSelection() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: _features.map((feature) {
        return FilterChip(
          label: Text(feature),
          selected: _selectedFeatures[feature] ?? false,
          onSelected: (bool selected) {
            setState(() {
              _selectedFeatures[feature] = selected;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}