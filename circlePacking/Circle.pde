class Circle {
 float x;
 float y;
 float radius;
 
 boolean growing = true;
 
 Circle(float x, float y){
    this.x = x;
    this.y = y;
    this.radius = 1;
 }
 
 void grow(){
   if(growing){
     radius += .5;
   }
 }
 
 boolean edges(){
    return (x + radius > width || x - radius < 0 || y + radius > height || y - radius < 0);
 }
 
 void show(){
   stroke(255);
   strokeWeight(2);
   noFill();
   ellipse(x, y, radius * 2, radius *2); 
 }
  
}