class StatusCodeHelper {

  // class for catching and returning error messages AR_ENLocalization can be implemented
  static String getResponse(int responseCode) {
    String responseStr = '';
    switch (responseCode) {
      case 404:
        responseStr = 'page_note_found';
        break;
      case 500:
        responseStr = 'server_error';
        break;
    }
    return responseStr;
  }

}
