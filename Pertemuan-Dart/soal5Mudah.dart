
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class Solution {
  ListNode? mergeTwoLists(ListNode? l1, ListNode? l2) {
    ListNode dummy = ListNode(0);
    ListNode tail = dummy;
    while (l1 != null && l2 != null) {
      if (l1.val < l2.val) {
        tail.next = l1;
        l1 = l1.next;
      } else {
        tail.next = l2;
        l2 = l2.next;
      }
      tail = tail.next!;
    }
    tail.next = (l1 != null) ? l1 : l2;
    return dummy.next;
  }
}

void printList(ListNode? head) {
  while (head != null) {
    print(head.val);
    head = head.next;
  }
}

void main() {
  var sol = Solution();

  var l1 = ListNode(1, ListNode(2, ListNode(4)));

  var l2 = ListNode(1, ListNode(3, ListNode(4)));

  var merged = sol.mergeTwoLists(l1, l2);
  printList(merged); 

}
