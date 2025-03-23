#ifndef FULLADDER_H
#define FULLADDER_H

class FullAdder
{
public:
    float PA, PB, PCi;
    float EswA, EswB, EswCi;
    FullAdder();
    FullAdder(float pa, float pb, float pci);
    float PS();
    float PCo();
    float EswS();
    float EswCo();

private:
    float PA_n, PB_n, PCi_n;
};

#endif
