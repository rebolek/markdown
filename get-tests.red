Red[]

do https://raw.githubusercontent.com/rebolek/red-tools/master/json.red

download-data: func [
	/local page link
][
	page: read https://spec.commonmark.org/
	parse page [
		thru "All versions:"
		thru {href="}
		copy link to {"}
	]
	link: rejoin [https://spec.commonmark.org/ link %spec.json]
	; NOTE: Sometimes reading it as string directly throws invalid UTF8 error...
	data: to string! read/binary link
	json/decode data
]

save %tests download-data
