#include <stdio.h>

struct Expressao{
    enum tipo{Num=1, Add, Sub}type;
    int n;
    struct Expressao *p1, *p2;
};

int avalia(struct Expressao e){
    switch(e.type){
        case Num:
            return e.n;
            break;
        case Add:
            return (avalia(*(e.p1)) + avalia(*(e.p2)));
            break;
        case Sub:
            return (avalia(*(e.p1)) - avalia(*(e.p2)));
            break;
        default:
            break;
    }
}

int main(){
    struct Expressao e1, e2, e3, e4, e5;
    e3.type = 1; e3.n = 1;
    e4.type = 1; e4.n = 2;
    e5.type = 1; e5.n = 5;
    e2.type = 2; e2.p1 = &e3; e2.p2 = &e4;
    e1.type = 3; e1.p1 = &e2; e1.p2 = &e5;
    printf("%d\n", avalia(e1));
}