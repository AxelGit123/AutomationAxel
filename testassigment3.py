def sort_evens_then_odds(arr):
    """
    Sorts the input array so that even numbers come first in descending order,
    followed by odd numbers in descending order.

    Parameters:
    arr (list of int): The input list of integers.

    Returns:
    list of int: The sorted list with even numbers first followed by odd numbers.
    """
    # Separate even and odd numbers
    evens = [x for x in arr if x % 2 == 0]
    odds = [x for x in arr if x % 2 != 0]
    
    # Sort both lists in descending order
    evens.sort(reverse=True)
    odds.sort(reverse=True)
    
    # Combine both lists (evens first, then odds)
    return evens + odds

# Example usage
input_list = [3, 2, 5, 1, 8, 9, 6]
sorted_list = sort_evens_then_odds(input_list)
print(sorted_list)  # Output: [8, 6, 2, 9, 5, 3, 1]
