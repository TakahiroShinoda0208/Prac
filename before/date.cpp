#include <iostream>//標準データ入出力
#include <fstream>//ファイルの入出力
#include <vector>//vector(動的配列クラス)
#include <string>//string(文字列クラス)
#include <sstream>//文字列の入出力
#include <unordered_map>//unordered_map関数の導入
#include <map>//map関数の導入
#include <set>//set関数の導入
#include <stdlib.h>//絶対値を用いるための関数
#include <algorithm>    // std::copy
#include<iomanip>//少数点以下表示
#include<time.h>
using namespace std;

//構造体宣言
struct Struct
{
      int date;
      int pros; //profit and loss
      int pro;
      int los;
      double npro;
      double nlos;
      int z0;
      int z1;
      int z2;
      int z3;
      int z4;
      int z5;
      int z6;
      int z7;
      int z8;
      int z9;
      int z10;
      Struct(int a=0,int b=0,int c=0,int d=0,double e=0,double f=0,int g=0,int h=0,int i=0,int j=0,int k=0,int l=0,int m=0,int n=0,int o=0,int p=0,int q=0)
      {
            // デフォルト引数
            this->date = a;
            this->pros = b;
            this->pro = c;
            this->los = d;
            this->npro = e;
            this->nlos = f;
            this->z0 = g;
            this->z1 = h;
            this->z2 = i;
            this->z3 = j;
            this->z4 = k;
            this->z5 = l;
            this->z6 = m;
            this->z7 = n;
            this->z8 = o;
            this->z9 = p;
            this->z10 = q;
            
      }     
};
//関数プロトタイプ宣言
vector<string> split(const string &str, char sep);
void devide(ifstream &fin0,ifstream &fin1);

//main関数
int main(int argc,char*argv[])
{    
      ifstream fin0;
      ifstream fin1;

      for(int i=0;i<argc;i++){

            string ss=argv[i];
            if(ss=="-f"){
                  fin0.open(argv[i+1]);     
                  fin1.open(argv[i+1]);
            }
            
      }
      
//入力ファイルが存在しなかった時の出力
      if(argc<=2){
            cout << endl;
            cout <<"\t"<<"D  A  T  E"<<"\n\n\n";
            
            cout <<"version 1.2" <<"\n";
            cout <<"updated 2016/09/03"<<"\t"<<"TAKAHIRO SHINODA"<<"\n\n\n";
            cout << "This is the tool for analyis of stock data." <<"\n\n\n";
            cout <<"example"<<"\n\n";
            cout <<"STOCK -f aiueo.tsv  > hoge.tsv"<<"\n";
            cout << "-----------------------------------------------------------------------------------------" << endl;
            cout << "-f"<<"\t\t"<<" : result file"<< endl;
            cout << "-----------------------------------------------------------------------------------------" <<"\n\n\n";
            return 1;
      }

      devide(fin0,fin1);
      
      return 0;

}

//split関数
vector<string> split(const string &str, char sep)
{
      vector<string> v;
      stringstream ss(str);
      string buffer;
      while( getline(ss, buffer, sep) ) {
            v.push_back(buffer);     
      }
      return v;     
}


void devide(ifstream &fin0,ifstream &fin1)
{
      string line;
      double aa=0;
      int flag=0;

      int x=0;
      double y=0;
      int z=0;
      
      int max=0;
      map<int,Struct> mp;
      vector<string> tmp;
      
      while(getline(fin0,line)){
            tmp= split(line,'\t');
            z=stoi(tmp[11]);
            if(max<z){
                  max = z;
            }
      }
      fin0.close();
      
      for(int i=1;i<=max;i++){
            Struct a0;
            mp[i]=a0;
      }


      while(getline(fin1,line)){
            tmp= split(line,'\t');
            x=stoi(tmp[9]);
            y=stod(tmp[12]);
            z=stoi(tmp[11]);

            mp[z].date+=1;
            mp[z].pros+=x;
            
            if(x>0){
                  mp[z].pro+=x;
                  mp[z].npro+=1;
            }else{
                  mp[z].los+=x;
                  mp[z].nlos+=1;
            }

            if(y == 0.5){
                  mp[z].z0+=1;
            }else if(y == 1){
                  mp[z].z1+=1;
            }else if(y == 1.5){
                  mp[z].z2+=1;
            }else if(y == 2){
                  mp[z].z3+=1;
            }else if(y == 2.5){
                  mp[z].z4+=1;
            }else if(y == 97.5){
                  mp[z].z5+=1;
            }else if(y == 98){
                  mp[z].z6+=1;
            }else if(y == 98.5){
                  mp[z].z7+=1;
            }else if(y == 99){
                  mp[z].z8+=1;
            }else if(y == 99.5){
                  mp[z].z9+=1;
            }else{
                  mp[z].z10+=1;
            }
      }
      
      for(int i=1;i<=max;i++){
            cout << i <<"\t"<<mp[i].date<<"\t"<<mp[i].pros<<"\t"<<(int)mp[i].npro<<"\t"<<(int)mp[i].nlos<<"\t"<<mp[i].pro<<"\t"<<mp[i].los<<"\t"<< mp[i].npro/(mp[i].npro+mp[i].nlos)*100 <<"\t";
            cout << mp[i].z0 <<"\t"<<mp[i].z1<<"\t"<<mp[i].z2<<"\t"<<mp[i].z3<<"\t"<<mp[i].z4<<"\t"<<mp[i].z5<<"\t"<<mp[i].z6<<"\t"<<mp[i].z7<<"\t"<<mp[i].z8<<"\t"<<mp[i].z9<<"\t"<<mp[i].z10<<endl;
      }
      
}

