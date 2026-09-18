table.reduce=function(a,b,c)local d=c;for e,f in ipairs(a)do if 1==e and not c then d=f else d=b(d,f)end end;return d end
