$TITLE Colorado Model

Sets
    i   plants  / Denver, Pueblo, Weld /
    j markets   / Denver, Golden, Boulder /
    e energy    / Solar, Gas, Wind /
    ;

Parameters                                         
    
 Table c(e,i)  cost of energy type e at plant i:
             Denver    Pueblo    Weld
Gas          8.34        7.38     7.26
Solar        0.05       0.049     0.047
Wind         0.03237    0.04235   0.03962 ;

 Table p(e,i)  price of energy type e at plant i:
             Denver    Pueblo    Weld
Gas          9.18        8.12     7.98
Solar        0.0695      0.065    0.062
Wind         0.035607    0.046585  0.043582 ;

 Table d(j,i)  distance in miles:
             Denver    Pueblo    Weld
Golden       36.8        128     65.6
Boulder      39.9        147     55
Denver        0          119     51.2 ;

 Table cap(e,i)  capacity of energy type e at plant i:
             Denver    Pueblo  Weld
Gas          8.3       120     16
Solar        8.3       120     16
Wind         8.3       120     16 ;

 Table dem(e,j)  demand of energy type e at market j:
             Denver    Golden  Boulder
Gas          169       290     111
Solar        180       121     218
Wind         297       181     230 ;

Scalar f transmission cost in cents /0.06/ ;

Parameter tc(j,i) transmission cost;
    tc(j,i) = f *d(j,i) ;

Positive Variable x

Variables
    x(e,i,j) type of energy and quantity of power transmitted in MWh
    y      total transmission cost
    z      objective function value
;


Equations
    cost
    supply(e,i) limit of energy e at plant i
    demand(e,j) demand of energy e at market j ;
    
cost .. y =e= sum((e,i,j), tc(j,i)*x(e,i,j)) ;
supply(e,i) .. sum(j, x(e,i,j)) =l= cap(e,i) ;
demand(e,j) .. sum(i, x(e,i,j)) =g= dem(e,j) ;

Model FuelsModel /all/ ;
Solve FuelsModel using lp minimizing y ;
Display x.l, x.m, demand.m