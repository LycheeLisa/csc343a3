declare variable $dataset0 external;

<important>{
let $d := $dataset0//posting
let $m := max(
             (for $p in $d//posting
              let $product :=  ($p//reqSkill/@level)*($p//reqSkill/@importance)
              return $product))
for $p2 in $d//posting
let $product2 :=  ($p2//reqSkill/@level)*($p2//reqSkill/@importance)
where $product2 = $m 
return $p2
}</important>
