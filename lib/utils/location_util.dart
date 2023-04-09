const googleApiKey = 'AIzaSyCdmbRTLo-BC051SMHhOtzd0RVFkPyECdk';

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'
        '&markers=color:blue%7Clabel:A%7C$latitude,$longitude'
        '&key=$googleApiKey';
  }
}
