#include "FullAdder.h"
#include <iostream>
#include <array>
#include <cstdlib>
#include <iomanip>

int main(int argc, char *argv[])
{
    using namespace std;

    const int Nbit = 8;
    float PA = atof(argv[1]);
    float PB = atof(argv[2]);
    float PCi = atof(argv[3]);
    array<FullAdder, Nbit> RCA;

    for (int i = 0; i < Nbit; i++)
    {
        if (i == 0)
        {
            FullAdder tmp(PA, PB, PCi);
            RCA[i] = tmp;
        }
        else
        {
            FullAdder tmp(PA, PB, RCA[i - 1].PCo());
            RCA[i] = tmp;
        }
    }
    cout << setw(7) << "P" << setw(12) << "Esw" << '\n';
    for (int i = Nbit - 1; i >= 0; i--)
    {
        cout << "S" << setw(5) << left << i << setw(10) << left << RCA[i].PS() << RCA[i].EswS() << '\n';
        cout << "Co" << setw(4) << left << i << setw(10) << left << RCA[i].PCo() << RCA[i].EswCo() << '\n';
    }
    
    return 0;
}
