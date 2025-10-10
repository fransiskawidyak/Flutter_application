
class Solution {
  bool isPalindrome(int x) {
    String s = x.toString();
    String rev = s.split('').reversed.join();
    return s == rev;
  }
}

void main() {
  var sol = Solution();
  print(sol.isPalindrome(121)); 
  print(sol.isPalindrome(-121));
  print(sol.isPalindrome(10));  
}
