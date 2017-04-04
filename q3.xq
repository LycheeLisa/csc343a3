declare variable $dataset0 external;
<qualified>{
  let $parsed := $dataset0
  for $candidate in ($parsed//resume)
 where count($parsed//resume[@rID/string() = $candidate//@rID/string()]//skill/@what) >= 3
  return <candidate rID="{$candidate/@rID/string()}" numskills="{count($parsed//resume[@rID/string() = $candidate/@rID/string()]//skill/@what)}" citizenship="{$candidate//citizenship}"><name>{$candidate//forename/string()}</name></candidate>
}</qualified>
