/ PubSub utilities
/ Based on original https://github.com/KxSystems/kdb-tick/blob/master/tick/u.q

\d .u

init:{w::(t!(count t::tables`.)#()),w;}

del:{w[x]_:w[x;;0]?y};pc:{del[;x]each t};

sel:{$[`~y;x;select from x where sym in y]}

pub:{[t;x]{[t;x;w]if[count x:sel[x]w 1;(neg first w)(`upd;t;x)]}[t;x]each w t}

add:{$[(count w x)>i:w[x;;0]?.z.w;.[`.u.w;(x;i;1);union;y];w[x],:enlist(.z.w;y)];(x;$[99=type v:value x;sel[v]y;@[0#v;`sym;`g#]])}

mt:{$[x~`;t;0=tx:type x;raze .z.s each x;10=tx;t where t like x;x]}    / match tables

sub:{s:$[((),y)~1#`$"*";`;y];if[11=type a:mt x;:sub[;s]each a];if[not x in t;'x];del[x].z.w;add[x;s]}

/ wrap sub - handles lists and dictionaries
wsub:{($[99=type x;sub'[key x;`$get x];((),x)~1#"*";sub[`;`];type[x]in 0 10h;sub[x;`];assert];$[.proc.self.pkg=`tp;`.u `i`L;()])}

handles:{union/[w[;;0]]}

end:{neg[handles`]@\:(`.u.end;x)}