#!/usr/bin/python3

import m

flag_utf8 = False
end = ''

for char in m.sys.argv[1]:
	if char == 'f':
		flag_file = True
	elif char == 'u':
		flag_utf8 = True
	elif char == 'e':
		flag_file = False
	elif char == 'n':
		end = '\n'

if flag_file:
	with open(m.sys.argv[2], 'rb') as file:
		code = file.read()
	if flag_utf8:
		code = ''.join(char for char in code.decode('utf-8').replace('\n', '¶') if char in m.code_page)
	else:
		code = ''.join(m.code_page[i] for i in code)
else:
	code = m.sys.argv[2]
	if flag_utf8:
		code = ''.join(char for char in code.replace('\n', '¶') if char in m.code_page)
	else:
		code = ''.join(m.code_page[ord(i)] for i in code)

args = list(map(m.try_eval, m.sys.argv[3:]))

for index in range(min(5, len(args))):
	m.atoms['³⁴⁵⁶⁷'[index]].call = lambda literal = args[index]: literal

m.output(m.m_eval(code, args[:2]), end)