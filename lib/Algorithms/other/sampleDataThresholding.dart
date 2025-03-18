/// Returns an appropriate threshold value for a given number.
/// The threshold value is used to avoid excessive zooming in/out of the
/// graph when the user is clicking on a point on the scatter plot.
/// The threshold value is calculated as follows:
/// - For numbers between 10,000 and 1,00,000, the threshold value is 1000.
/// - For numbers between 1000 and 10,000, the threshold value is 500.
/// - For numbers between 200 and 1000, the threshold value is 50.
/// - For numbers between 100 and 200, the threshold value is 10.
/// - For numbers between 10 and 100, the threshold value is 5.
/// - For all other numbers, the threshold value is 1.
int calculateThreshold(int number) {
      int val = 1;
    if (number > 0) {
      if(number >10000 && number <= 1000000){
        val = 1000;
      }
      if (number >1000 && number <= 10000) {
        val = 500; // For numbers between 10,000 and 1,00,000
      }
      if(number > 200 && number <= 1000){
        val = 25;
      }
      if(number > 100 && number <= 200){
        val = 5;
      }
      if(number > 10 && number <= 100){
        val = 5;
      }

    }
    return val;
  }
int calculateThreshold2(int number) {
      int val = 1;
    if (number > 0) {
      if(number >100000 && number <= 1000000){
        val = 10000;
      }
      if (number >1000 && number <= 100000) {
        val = 1000; // For numbers between 10,000 and 1,00,000
      }
      if(number > 200 && number <= 1000){
        val = 50;
      }
      if(number > 100 && number <= 200){
        val = 10;
      }
      if(number > 10 && number <= 100){
        val = 5;
      }

    }
    return val;}