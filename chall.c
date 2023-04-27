#include <stdio.h>

void win(){printf("congratulation!!\nHere flag!\nTKCTF{%c%c%c%c%c%c%c}", 0x59, 0x6f, 0x75, 0x5f, 0x70, 0x77, 0x6e);}

void a(){}

int main(void){
  struct keypair{
    char name[100];
    int admin;
    int key;
  };
  struct keypair keypair;
  printf("Hello user!\nPlease name!\n");
  scanf("%s", keypair.name);
  printf("OK! Hello %s, Please, key!\n", keypair.name);
  scanf("%d", &keypair.key);
  if(keypair.key == 65537)
    printf("congratulation!!\nHere flag!\nTKCTF{%c%c%c%c%c%c%c}", 0x59, 0x6f, 0x75, 0x5f, 0x70, 0x77, 0x6e);
  else
    printf("Oops...You are not hacker.....");
  void (*fun)() = &a;
  if(keypair.admin)
    fun = &win;
  fun();
  return 0;
}
