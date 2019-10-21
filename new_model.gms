$TITLE Colorado Model

Sets
    i   plants  / Denver, Pueblo, Weld /
    j markets   / Denver, Golden, Boulder /
    e energy    / Solar, Gas, Wind /
    ;

Parameters                                
    p_s(i) "price of solar at plant i in cases"
        /   Denver .0695
            pueblo .065
            weld .062   /
    p_g(i) "price of gas at plant i in cases"
        /   Denver 9.18
            pueblo 8.12
            weld 7.98   /      
    p_w(i) "price of wind at plant i in cases"
        /   Denver 0.035607
            pueblo 0.046585
            weld 0.043582   /          
    sc(i) "solar capacity of plant i in cases"
        /   denver 8.3
            pueblo 120
            weld   16 /
    wc(i) "wind capacity of plant i in cases"
        /   denver 8.3
            pueblo 120
            weld   16 /
    gc(i) "gas capacity of plant i in cases"
        /   denver 8.3
            pueblo 120
            weld   16 /        
    s(j) "solar demand of market j in cases"
        /   Denver 180
            Golden 290
            Boulder 111 /
    g(j) "gas demand of market j in cases"
        /   Denver 169
            Golden 121
            Boulder 230 /
    w(j) "wind demand of market j in cases"
        /   Denver 297
            Golden 181
            Boulder 218 /
            
    c(e,i) "cost of energy for each market"
    
    c("Solar",i) = c_s(i)
    c("Gas",i) = c_g(i)
    c("Wind",i) = c_w(i) 
;

 Table d(j,i)  cost of energy type e at plant i:
             Denver    Pueblo    Weld
Gas          8.34        7.38     7.26
Solar        0.05       0.049     0.047
Wind         0.03237    0.04235   0.03962 ;

 Table c(e,i)  distance in miles:
             Denver    Pueblo    Weld
Golden       36.8        128     65.6
Boulder      39.9        147     55
Denver        0          119     51.2 ;

Scalar f transmission cost in cents /0.06/;

Parameter c(j,i) transmission cost; c(j,i) = f *d(j,i) ;

Variables
    x(e,i,j) type of energy and quantity of power transmitted in MWh
    y      total transmission cost
    z      objective function value
;

Positive Variables
x(i,j) "power production for each market"
;

Equations
    cost
    supply(i) limit at plant i
    demand(j) demand at market j
;
    
cost..y =e= sum((i,j), c(j,i)*x(i,j))  ;
supply(i) .. sum(j, x(i,j)) =l= sc(i),gc(i),wc(i) ;
    