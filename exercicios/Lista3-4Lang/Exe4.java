abstract class Expressao{
    abstract int avalia();
    public static class Num extends Expressao {
        int n;
        Num(int n){
            this.n = n;
        }
        int avalia(){
            return this.n;
        }
    }
    public static class Add extends Expressao{
        Expressao e1, e2;
        Add(Expressao e1, Expressao e2){
            this.e1 = e1; this.e2 = e2;
        }
        int avalia(){
            return e1.avalia() + e2.avalia();
        }
    }
    public static class Sub extends Expressao{
        Expressao e1, e2;
        Sub(Expressao e1, Expressao e2){
            this.e1 = e1; this.e2 = e2;
        }
        int avalia(){
            return e1.avalia() - e2.avalia();
        }
    }
}

class EXE4{
    
    public static void main(String[] args){
        Expressao n1 = new Expressao.Num(1);
        Expressao n2 = new Expressao.Num(2);
        Expressao n3 = new Expressao.Num(5);
        Expressao a1 = new Expressao.Add(n1, n2);
        Expressao e1 = new Expressao.Sub(a1, n3);
        System.out.println(e1.avalia());
    }
}