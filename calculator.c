#include <stdio.h>
int main() {
    int num1;
    int num2;
    char operation;
    printf("Enter two integers. Press return after each integer.\n");
    scanf("%d", &num1);
    scanf("%d", &num2);
    printf("Enter an operation (+,-,*,/, or %%). Then press return.\n");
    scanf(" %c", &operation); // Note: Leading space in
    // format string is necessary!
    
    if (operation == '+'){
        printf("%d\n", num1 + num2);
    }
    else if (operation == '-'){
        printf("%d\n", num1 - num2);
    }
    else if (operation == '*'){
        printf("%d\n", num1 * num2);
    }
    else if (operation == '/'){
        printf("%d\n", num1 / num2);
    }
    else if (operation == '%'){
        printf("%d\n", num1 % num2);
    }
    
    return 0;
}
