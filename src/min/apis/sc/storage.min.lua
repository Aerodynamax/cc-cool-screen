local a=peripheral.find("inventory")local b=a;function b.totalCount()local c=0;for d=1,#b.size()do c=c+b.getItemDetail(1).count end;return c end;return b
