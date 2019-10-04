GAMS Model for the Colorado Solar Industry

Set
            i 'solar power farms' / denver, pueblo, weld /
            j 'markets'           / golden, boulder, denver / ;
           
Parameter
            a(i) 'capacity of plant i in cases in MW'
                                    / denver          8.3
                                      pueblo          120
                                      weld              16 /
           
            b(j) 'demand at market j in cases in MW'
                                    / golden          23
                                      boulder         50
                                      Denver          120 /
 

 Table d(i,j)  distance in miles
             Denver    pueblo    weld
Golden       36.8        128     65.6
 

Boulder      39.9        147     55
 

Denver        0          119     51.2
 

     
Scalar f  transmission cost in cent per kWh  /0.06/ ;
 

Parameter c(i,j)  transmission cost in cents per mWh ;
 

          c(i,j) = f * d(i,j) * 1000 ;
 

Positive Variable x ;
 

Equations
     cost        define objective function
     supply(i)    supply limit at plant i
     demand(j)   demand at market j ;
 

cost ..        z =e= sum((i,j), c(i,j)*x(i,j)) ;
 

supply(i) ..   sum(j, x(i,j)) =l=  a(i) ;
 

demand(j) ..   sum(i, x(i,j)) =g=  b(j) ;
 

Model co_solar_transport /all/ ;
 

Solve transport using lp minimizing z ;
 

Display x.l, x.m ;