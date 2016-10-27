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
      string way;
      string date;
      double devi;
      int value;
      Struct(string a, string b,double c=0,int d=0)
      {
            // デフォルト引数
            this->way = a;
            this->date = b;
            this->devi = c;
            this->value = d;
      }     
};
//関数プロトタイプ宣言
vector<string> split(const string &str, char sep);
void judge(ifstream &fin0,ifstream &fin1,double &x1,double &x2,double &x3,double &x4);

//main関数
int main(int argc,char*argv[])
{    
      ifstream fin0;
      ifstream fin1;
      double x025=0; //信頼区間min(95%信頼区間下限)
      double x250=0; //信頼区間4分位数的なやつ(25%)
      double x750=0; //信頼区間4分位数的なやつ(75%)
      double x975=0; //信頼区間max(95%信頼区間上限)

      for(int i=0;i<argc;i++){

            string ss=argv[i];
            if(ss=="-f0"){
                  fin0.open(argv[i+1]);     
            }
            
            if(ss=="-f1"){
                  fin1.open(argv[i+1]);     
            }
            if(ss=="-x"){
                  x025=atof(argv[i+1]);     
                  x250=atof(argv[i+2]);     
                  x750=atof(argv[i+3]);     
                  x975=atof(argv[i+4]);
            }
            
      }
      
//入力ファイルが存在しなかった時の出力
      if(!fin1 || argc<=5){
            cout << endl;
            cout <<"\t"<<"J  U  D  G  E"<<"\n\n\n";
            
            cout <<"version 1.1" <<"\n";
            cout <<"updated 2016/09/02"<<"\t"<<"TAKAHIRO SHINODA"<<"\n\n\n";
            cout << "This is the tool for analyis of stock data." <<"\n\n\n";
            cout <<"example"<<"\n\n";
            cout <<"STOCK -f aiueo.tsv  > hoge.tsv"<<"\n";
            cout << "-----------------------------------------------------------------------------------------" << endl;
            cout << "-f0"<<"\t\t"<<" : input csvfile"<< endl;
            cout << "-f1"<<"\t\t"<<" : input tsvfile of diviation rate"<< endl;
            cout << "-x"<<"\t\t"<<" : 信頼区間の値と第一4 分位数、第三4分位数"<<"\t\t\t\t"<< endl;
            cout << "-----------------------------------------------------------------------------------------" <<"\n\n\n";

            return 1;
            
      }

      judge(fin0,fin1,x025,x250,x750,x975);

      
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


void judge(ifstream &fin0,ifstream &fin1,double &x1,double &x2,double &x3,double &x4)
{
      string line;
      double aa=0;
      int flag=0;
      int z=0;
      map<string,int> mp;
      vector<string> tmp;
      vector<Struct> box;
      
      while(getline(fin0,line)){
            tmp= split(line,'\t');
            mp[tmp[0]]=stoi(tmp[6]);
      }

      while(getline(fin1,line)){
            tmp = split(line,'\t');
            aa = stod(tmp[1]);
            z++;
            
            switch(flag){
            case 0:
                  if(aa >= x4){
                        flag=1;
                        Struct a0("sell",tmp[0],aa,mp[tmp[0]]);
                        box.push_back(a0);
                        z=0;
                  }
                  if(aa <= x1){
                        flag=2;
                        Struct a0("buy",tmp[0],aa,mp[tmp[0]]);
                        box.push_back(a0);
                        z=0;
                  }
                  break;
            case 1:
                  if(aa<=x3){
                        flag=0;
                        Struct a0("buy",tmp[0],aa,mp[tmp[0]]);
                        box.push_back(a0);
                        
                        cout << box[0].way << "\t" << box[0].date <<"\t"<< box[0].devi <<"\t"<<  box[0].value <<"\t";
                        cout << box[1].way << "\t" << box[1].date <<"\t"<< box[1].devi <<"\t"<<  box[1].value <<"\t";
                        cout <<"損益"<<"\t"<<( box[0].value - box[1].value)<<"\t"<<"日数"<<"\t"<<z<<"\t"<< endl;

                        box.clear(); 
                        z=0;
                        
                  }
                  break;
                  
            case 2:     
                  if(aa>=x2){
                        flag=0;
                        Struct a0("sell",tmp[0],aa,mp[tmp[0]]);
                        box.push_back(a0);

                              cout << box[0].way << "\t" << box[0].date <<"\t"<< box[0].devi <<"\t"<<  box[0].value <<"\t";
                              cout << box[1].way << "\t" << box[1].date <<"\t"<< box[1].devi <<"\t"<<  box[1].value <<"\t";
                              cout <<"損益"<<"\t"<<( box[1].value - box[0].value)<<"\t"<<"日数"<<"\t"<<z<<"\t"<< endl;

                        box.clear();
                        z=0;
                  }
                  break;
                  
            default:
                  cout <<"フラッグが正常に機能していません。"<<endl;
                  break;
            }
      }      
}

