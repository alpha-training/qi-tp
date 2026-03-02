/ PubSub utilities
/ Based on original https://github.com/KxSystems/kdb-tick/blob/master/tick/u.q

\d .u

init:{w::(t!(count t::tables`.)#()),w;}

del:{w[x]_:w[x;;0]?y};pc:{del[;x]each t};

sel:{$[`~y;x;select from x where sym in y]}

pub:{[t;x]{[t;x;w]if[count x:sel[x]w 1;(neg first w)(`upd;t;x)]}[t;x]each w t}

add:{$[(count w x)>i:w[x;;0]?.z.w;.[`.u.w;(x;i;1);union;y];w[x],:enlist(.z.w;y)];(x;$[99=type v:value x;sel[v]y;@[0#v;`sym;`g#]])}

mt:{$[10=abs type x;t where t like x;x~`;t;x]}    / match tables

sub:{0N!(x;y);if[11=type a:mt x;:sub[;y]each a];if[not x in t;'x];del[x].z.w;add[x;y]}

handles:{union/[w[;;0]]}

end:{neg[handles`]@\:(`.u.end;x)}