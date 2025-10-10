import 'dart:io'; // Jangan lupa import ini untuk stdout

void main(List<String> arguments) {
  // Deklarasi list 
  List<int> f1 = [1, 2, 3, 4, 5]; 
  
  f1[2] = 3;
  f1[3] = 4;

  // Cetak 
  stdout.writeln(f1[0]); // Index 0: elemen pertama
  stdout.writeln(f1[1]); // Index 1: elemen kedua  
  stdout.writeln(f1[2]); // Index 2: elemen ketiga
  stdout.writeln(f1[3]); // Index 3: elemen keempat
  stdout.writeln(f1[4]); // Index 4: elemen kelima
}