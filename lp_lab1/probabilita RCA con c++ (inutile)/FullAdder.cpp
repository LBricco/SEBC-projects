#include "FullAdder.h"
#include <iostream>

FullAdder::FullAdder() {}

FullAdder::FullAdder(float pa, float pb, float pci)
{
    PA = pa;
    PB = pb;
    PCi = pci;
    PA_n = 1 - pa;
    PB_n = 1 - pb;
    PCi_n = 1 - pci;
}

// calcola probabilità somma
float FullAdder::PS()
{
    return (PA_n * PB_n * PCi) + (PA_n * PB * PCi_n) + (PA * PB_n * PCi_n) + (PA * PB * PCi);
}

// calcola probabilità carry out
float FullAdder::PCo()
{
    return (PA_n * PB * PCi) + (PA * PB_n * PCi) + (PA * PB * PCi_n) + (PA * PB * PCi);
}

// calcola attività somma
float FullAdder::EswS()
{
    return 2 * PS() * (1 - PS());
}

// calcola attività carry out
float FullAdder::EswCo()
{
    return 2 * PCo() * (1 - PCo());
}
