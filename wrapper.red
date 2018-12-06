Red[]

round-pct: func [value][
	round/to to percent! value / to float! length 0.01
]

; load code and remove unnecessary part
body: load %markdown.red
remove/part body 2
body: find body quote text-file
clear body

; add custom code and make function
append body [
html/gen-html/no-template/no-toc scanner/scan-doc data
]
markdown: function [data] body: head body

; load and run tests
tests: reduce load %tests
length: length? tests
section: none
results: [
	passed: 0
	failed: 0
	error: 0
]
foreach test tests [
	unless equal? section test/section [
		section: test/section
		print ["===" section "==="]
	]
	result: try [markdown test/markdown]
	result: case [
		error? result [results/error: results/error + 1 "!!! ERROR !!!"]
		not equal? test/html result [results/failed: results/failed + 1 "failed"]
		'default [results/passed: results/passed + 1 "OK"]
	]
	print [test/example result] 
]
print [
	"==================================" newline
	"passed:" results/passed round-pct results/passed newline
	"failed:" results/failed round-pct results/failed newline
	"error: " results/error round-pct results/error newline
]
