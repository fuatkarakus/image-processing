unction result = bcv(h,level)
nom = 0;
denom=0;

wb = sum(h(1:level))/sum(h(1:256));
ww = sum(h(level+1:256))/sum(h(1:256));

mb = 0;
for i = 1:level
    mb = mb+ (i-1)*h(i);
end
mb = mb/sum(h(1:level));

mw = 0;
for i = level+1:256
    mw = mw+ (i-1)*h(i);
end
mw = mw/sum(h(level+1:256));

result = wb*ww*(mb-mw)*(mb-mw);