require("sc.reduce")local a=peripheral.find("inventory")local b=a;function b.totalCount()return table.reduce(b.list(),function(c,d)return c+d.count end,0)end;return b
