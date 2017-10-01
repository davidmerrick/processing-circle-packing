ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage image;

void setup(){
  size(1600, 900);
  spots = new ArrayList<PVector>();
  circles = new ArrayList<Circle>();
  circles.add(new Circle(200, 200));
  image = loadImage("text.jpg");
  image.loadPixels();
  for(int x = 0; x < image.width; x++){
     for(int y = 0; y < image.height; y++){
       int index = x + y * image.width;
       color c = image.pixels[index];
       float brightness = brightness(c);
       if(brightness > 1){
           spots.add(new PVector(x, y));
       }
     }
  }
  
}

void draw(){
   background(0); 
   
   int total = 10;
   int count = 0;
   int attempts = 0;
   final int ATTEMPTS_THRESHOLD = 1000;
   
   while(count < total){
     Circle newCircle = newCircle(); 
     if(newCircle != null){
        circles.add(newCircle);
        count++;
     }
     attempts++;
     if(attempts > ATTEMPTS_THRESHOLD){
        noLoop();
        println("FINISHED");
     }
   }
   
   for(Circle circle: circles){
     if(circle.growing){
       if(circle.edges()){
          circle.growing = false; 
       } else {
          for(Circle other : circles){
              if(circle != other){
                float distance = dist(circle.x, circle.y, other.x, other.y);
                if(distance < circle.radius + other.radius){
                  circle.growing = false;
                }
              }
          }
       }
     }
     circle.show();
     circle.grow();
   }
}

Circle newCircle(){
  int randomSpot = int(random(0, spots.size()));
  PVector spot = spots.get(randomSpot);
  
  float x = spot.x;
  float y = spot.y;
  
  boolean valid = true;
  
  for(Circle circle: circles){
     float distance = dist(x, y, circle.x, circle.y);
     if(distance < circle.radius){
       valid = false;
       break;
     }
   }
  
  if(valid){
    return new Circle(x, y);
  }
  
  return null;
}