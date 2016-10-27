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

//関数プロトタイプ宣言
vector<string> split(const string &str, char sep);
void deviation_rate(vector<double>&a,vector<double>&b,int &x,ifstream &fin1);

//main関数
int main(int argc,char*argv[1])
{    
      ifstream fin1;
      int x=7; //default 平均日数

      for(int i=0;i<argc;i++){

            string ss=argv[i];
            if(ss=="-f"){
                  fin1.open(argv[i+1]);     
            }
            if(ss=="-x"){
                  x=atoi(argv[i+1]);     
            }
            
      }
      
//入力ファイルが存在しなかった時の出力
      if(!fin1 || argc<=2){
            cout << endl;
            cout <<"\t"<<"S   T   O   C   K"<<"\n\n\n";
            
            cout <<"version 1.0.0" <<"\n";
            cout <<"updated 2016/07/20"<<"\t"<<"TAKAHIRO SHINODA"<<"\n\n\n";
            cout << "This is the tool for analyis of stock data." <<"\n\n\n";
            cout <<"example"<<"\n\n";
            cout <<"STOCK -f aiueo.fa -x 5 > hoge.tsv"<<"\n";
            cout << "-----------------------------------------------------------------------------------------" << endl;
            cout << "-f"<<"\t\t"<<" : input csvfile"<< endl;
            cout << "-x"<<"\t\t"<<" : period of moving average rate of deviation"<<"\t\t\t\t"<<"[default 7]"<< endl;
            cout << "-----------------------------------------------------------------------------------------" <<"\n\n\n";

            return 1;
            
      }
      
      //refgenomeの格納
      vector<double>a; //配列
      vector<double>b; //配列
      deviation_rate(a,b,x,fin1);
      fin1.close();
      
      //cout << "end\n";
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


void deviation_rate(vector<double>&a,vector<double>&b,int &x,ifstream &fin1)
{
      string line;
      string name;
      int aa=0;
      vector<string> tmp;
      vector<double> ratebox;
      vector<string> date;

      //getline(fin1,line);
      //name=line;
      //残りのデータを格納していく
      while(getline(fin1,line)){
            tmp= split(line,'\t');
            aa=stoi(tmp[6]);
            a.push_back(aa);
            date.push_back(tmp[0]);
            
      }

      //cout << name << endl;
      
      int y=0;
      double sum=0;
      double average=0;
      double rate =0;            
      
      for(int i=a.size()-1;i>=0;i--){

            y++;
            if(y>x){
                  average = sum/x;
                  rate = (a[i]/average)-1;
                  //cout << rate << endl;
                  cout << date[i] << "\t" << rate << endl;

                  //cout << sum <<"\t"<< average<<"\t"<<rate<< endl;

                  ratebox.push_back(rate);
                  sum = sum - a[i+x] + a[i];
            }
            else{
                  sum+= a[i];
            }
            
      }
      
      
}
