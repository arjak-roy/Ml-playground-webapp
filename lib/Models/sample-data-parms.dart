class Sampledataparms {
   double _intercept;
   double _slope;
   double _noise;
   int _noOfDataPoints;
  Sampledataparms(this._intercept, this._slope, this._noise, this._noOfDataPoints);
  get intercept => _intercept;
  get slope => _slope;
  get noise => _noise;
  get noOfDataPoints => _noOfDataPoints;
  set intercept(value) => _intercept = value;
  set slope(value) => _slope = value;
  set noise(value) => _noise = value;
  set noOfDataPoints(value) => _noOfDataPoints = value;
}