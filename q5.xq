declare variable $dataset0 external;
declare variable $dataset1 external;
let $d1 := $dataset0//posting
let $d2 := $dataset1//resume
let $counter := 0
for $skill in distinct-values($d1//reqSkill/@what)
return
<histogram>{
for $i in 1 to 5
return
<skill name = "{$skill}"><count level = "{$i}" n="{
sum(for $resume in $d2//resume
return
<sum>{
if ($resume//skill[@what = $skill and @level = $i]) then (1) else (0)
}</sum>)}"/>
</skill>
}</histogram>  
