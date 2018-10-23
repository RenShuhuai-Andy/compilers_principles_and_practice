struct a{
    int b;
}cc;
float a[4];
int a[3][2];//二维数组
int a,b,c;
float m,n;
int fibo(int a){
    if(a==1||a==2)
        return 1;
    return fibo(a-1)+fibo(a-2);
}
int main(){
    char c='0';/*注释*/
    int m,n,i;
    m=read();
    ++i;
    m+=1;
    while(i<=m){
        n=fibo(i);
        write(n);
        i=i+1;
    }
    return 1;
}