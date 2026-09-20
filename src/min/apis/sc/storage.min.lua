local a=peripheral.find("inventory")local b=a;function b.totalCount()local c=0;for d=1,b.size()do local e=b.getItemDetail(d)if e~=nil then c=c+e.count end end;return c end;return b
