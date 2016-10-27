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
void judge(ifstream &fin0,ifstream &fin1);

//main関数
int main(int argc,char*argv[])
{    
      ifstream fin0;
      ifstream fin1;

      for(int i=0;i<argc;i++){

            string ss=argv[i];
            if(ss=="-f0"){
                  fin0.open(argv[i+1]);     
            }

            if(ss=="-f1"){
                  fin1.open(argv[i+1]);     
            }

      }
      
//入力ファイルが存在しなかった時の出力
      if(!fin1 || argc<=3){
            cout << endl;
            cout <<"\t"<<"J  U  D  G  E"<<"\n\n\n";
            
            cout <<"version 1.3" <<"\n";
            cout <<"updated 2016/10/15"<<"\t"<<"TAKAHIRO SHINODA"<<"\n\n\n";
            cout << "This is the judge tool for decision of confidence and stabe interval region." <<"\n\n\n";
            cout <<"OUTPUT deviation file with confidence region value." << "\n\n\n";
            cout <<"e.g."<<"\n\n";
            cout <<"STOCK -f0 aiueo_7.tsv -f1 R.tsv  > hoge.tsv"<<"\n";
            cout << "-----------------------------------------------------------------------------------------" << endl;
            cout << "-f0"<<"\t\t"<<" : input tsv file format of deviation rate"<< endl;
            cout << "-f1"<<"\t\t"<<" : input the result of script_R2"<< endl;
       
            cout << "-----------------------------------------------------------------------------------------" <<"\n\n\n";

            return 1;
            
      }

      judge(fin0,fin1);
      
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


void judge(ifstream &fin0,ifstream &fin1)
{
      string line;
      double aa=0;
      int z=0;
      map<string,int> mp;
      vector<string> tmp;
      vector<Struct> box;
      vector<double> R;
      
//Rの中に、信頼区間の値を入れておく
      while(getline(fin1,line)){
            R.push_back(stof(line));
      }
      
      
      while(getline(fin0,line)){
            tmp = split(line,'\t');
            aa = stod(tmp[1]);
            
            if(aa<=R[0]){
                  cout << line <<"\t"<<0.5<<endl;
            }else if(aa<=R[1]){
                  cout << line <<"\t"<<1.0<<endl;
            }else if(aa<=R[2]){
                  cout << line <<"\t"<<1.5<<endl;
            }else if(aa<=R[3]){
                  cout << line <<"\t"<<2.0<<endl;
            }else if(aa<=R[4]){
                  cout << line <<"\t"<<2.5<<endl;
            }else if(aa>=R[11]){
                  cout << line <<"\t"<<99.5<<endl;
            }else if(aa>=R[10]){
                  cout << line <<"\t"<<99.0<<endl;
            }else if(aa>=R[9]){
                  cout << line <<"\t"<<98.5<<endl;
            }else if(aa>=R[8]){
                  cout << line <<"\t"<<98.0<<endl;
            }else if(aa>=R[7]){
                  cout << line <<"\t"<<97.5<<endl;
            }else{
                  cout << line <<"\t"<<0<<endl;
            }
            
      }     
}

