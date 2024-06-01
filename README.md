# DBATool
Tool for playing DBA

swipl
[dba].


'''
move(Move, Element, Remarks).
move(Move, Element, 'fast foot', Remarks).
subsequent_move(Element, Remarks).
interpenetration(Move, Element, Across).
combat_factor(Element, Foot, Mounted, Remarks).
rear_support(Factor, Element, Against, Remarks).
flank_support(Factor, Element, Type, Remarks).
tactical_factors(Factor, Element, Remarks).
outcome('tie', Element, Against, Outcome, Remarks).
outcome('lose', Element, Against, Outcome, Remarks).
outcome('double', Element, Against, Outcome, Remarks).

print_element(Element).
print_element(Element, Type).
'''

print_element(Element) will print out the info needed to play a given element.
Use print_element(Element, 'fast foot') or print_element(Element, 'solid foot') to specify element type.

Use outcome to get the outcome of a fight, either for a 'tie', a loss ('lose') or a loss by double ('double').
