
class Solution {
  bool isValid(String s) {
    List<String> stack = [];
    Map<String, String> pairs = {')': '(', ']': '[', '}': '{'};
    for (String ch in s.split('')) {
      if (pairs.containsValue(ch)) {
        stack.add(ch);
      } else if (pairs.containsKey(ch)) {
        if (stack.isEmpty || stack.removeLast() != pairs[ch]) {
          return false;
        }
      }
    }
    return stack.isEmpty;
  }
}

void main() {
  var sol = Solution();
  print(sol.isValid("()"));     
  print(sol.isValid("()[]{}")); 
  print(sol.isValid("(]"));  
}
