
fast_foot('Pk').
fast_foot('Bd').
fast_foot('Ax').
fast_foot('Bw').
fast_foot('Ps').
fast_foot('Wb').
fast_foot('Hd').

solid_foot('Sp').
solid_foot('Pk').
solid_foot('Bd').
solid_foot('Ax').
solid_foot('Bw').
solid_foot('Wb').
solid_foot('Hd').
solid_foot('CP').
solid_foot('CWg').
solid_foot('Lit').

ranged_troops('Bw').
ranged_troops('Art').
ranged_troops('WWg').
ranged_troops('CWg').

any_mounted('El').
any_mounted('Kn').
any_mounted('SCh').
any_mounted('Cv').
any_mounted('Cm').
any_mounted('LH').

any_foot('Sp').
any_foot('Pk').
any_foot('Bd').
any_foot('Ax').
any_foot('Bw').
any_foot('Ps').
any_foot('Wb').
any_foot('Hd').
any_foot('Art').
any_foot('WWg').
any_foot('CP').
any_foot('CWg').
any_foot('Lit').
any_foot('camp followers').
any_foot('city denizens').

any_troops('El').
any_troops('Kn').
any_troops('SCh').
any_troops('Cv').
any_troops('Cm').
any_troops('LH').
any_troops('Sp').
any_troops('Pk').
any_troops('Bd').
any_troops('Ax').
any_troops('Bw').
any_troops('Ps').
any_troops('Wb').
any_troops('Hd').
any_troops('Art').
any_troops('WWg').
any_troops('CP').
any_troops('CWg').
any_troops('Lit').
any_troops('camp followers').
any_troops('city denizens').


% move

move(4, Element, Remarks) :-
	member(Element, ['LH', 'Cv', 'SCh']),
	Remarks = 'in good going'.

move(3, Element, Remarks) :-
	member(Element, ['Kn', 'El', 'Cm', 'Mtd-']),
	Remarks = 'in good going'.

move(3, Element, Remarks) :-
	fast_foot(Element),
	Remarks = 'fast foot in any going'.

move(2, Element, Remarks) :-
	member(Element, ['Ax', 'Wb']),
	Remarks = 'solid foot in any going'.

move(2, Element, Remarks) :-
	( solid_foot(Element); member(Element, ['camp followers', 'city denizens']) ),
	Remarks = 'solid foot in good going'.

move(1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'in bad or rough going, or traversing non-paltry river'.

move(0, Element, Remarks) :-
	member(Element, ['Art', 'WWg']),
	Remarks = 'cannot move offroad in bad going terrain'.



move(4, Element, _, Remarks) :-
	member(Element, ['LH', 'Cv', 'SCh']),
	Remarks = 'in good going'.

move(3, Element, _, Remarks) :-
	member(Element, ['Kn', 'El', 'Cm', 'Mtd-']),
	Remarks = 'in good going'.

move(3, Element, Type, Remarks) :-
	fast_foot(Element),
  Type = 'fast foot',
	Remarks = 'fast in any going'.

move(2, Element, Type, Remarks) :-
	member(Element, ['Ax', 'Wb']),
  Type = 'solid foot',
	Remarks = 'solid foot in any going'.

move(2, Element, Type, Remarks) :-
	solid_foot(Element), not(member(Element, ['Ax', 'Wb'])),
  Type = 'solid foot',
	Remarks = 'solid foot in good going'.

move(2, Element, _, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	Remarks = 'in good going'.

move(1, Element, Type, Remarks) :-
	any_troops(Element), not(member(Element, ['Ax', 'Wb'])),
  Type \= 'fast foot',
	Remarks = 'in bad or rough going'.

move(1, Element, _, Remarks) :-
	any_troops(Element),
	Remarks = 'traversing non-paltry river'.

move(0, Element, _, Remarks) :-
	member(Element, ['Art', 'WWg']),
	Remarks = 'cannot move offroad in bad going terrain'.



subsequent_move(Element, Remarks) :-
	member(Element, ['LH', 'Mtd-']),
	Remarks = 'making a second or third move entirely in good going'.

subsequent_move(Element, Remarks) :-
	Element = 'Ps',
	Remarks = 'in the first bound, or if every element starts entirely in good going and ends partially in bad or rough going'.

subsequent_move(Element, Remarks) :-
	any_troops(Element),
	Remarks = 'moving along a road making a second or subsequent move'.


interpenetration(Move, Moving, Across) :-
	member(Move, ['move', 'flee']),
	any_mounted(Moving),
	Across = 'Ps'.

interpenetration(Move, Moving, Across) :-
	member(Move, ['move', 'flee']),
	Moving = 'Ps',
	any_troops(Across).

interpenetration(Move, Moving, Across) :-
	Move = 'recoil',
	any_mounted(Moving),
	any_troops(Across), not(member(Across, ['Pk', 'Hd', 'El'])).

interpenetration(Move, Moving, Across) :-
	Move = 'recoil',
	Moving = 'Bd',
	member(Across, ['Bd', 'Sp']).

interpenetration(Move, Moving, Across) :-
	Move = 'recoil',
	member(Moving, ['Pk', 'Bw']),
	Across = 'Bd'.

interpenetration(Move, Moving, Across) :-
	Move = 'recoil',
	Moving = 'Ps',
	any_troops(Across), Across \= 'Ps'.


% combat factor

combat_factor(Element, 5, 4, Remarks) :-
	Element = 'El',
	Remarks = ''.

combat_factor(Element, 5, 3, Remarks) :-
	member(Element, ['Bd', 'CP', 'CWg', 'Lit']),
	Remarks = 'in close combat'.

combat_factor(Element, 4, 4, Remarks) :-
	member(Element, ['Bd', 'CP', 'CWg', 'Lit']),
	Remarks = 'if shot at'.

combat_factor(Element, 4, 4, Remarks) :-
	Element = 'Sp',
	Remarks = ''.

combat_factor(Element, 4, 4, Remarks) :-
	Element = 'Art',
	Remarks = 'unless in a city or fort'.

combat_factor(Element, 3, 4, Remarks) :-
	member(Element, ['Kn', 'SCh', 'Pk', 'WWg']),
	Remarks = ''.

combat_factor(Element, 3, 3, Remarks) :-
	member(Element, ['Cv', 'Cm', 'Ax']),
	Remarks = ''.

combat_factor(Element, 3, 2, Remarks) :-
	member(Element, ['Wb', 'Hd']),
	Remarks = ''.

combat_factor(Element, 2, 4, Remarks) :-
	Element = 'Bw',
	Remarks = ''.

combat_factor(Element, 2, 2, Remarks) :-
	Element = 'Art',
	Remarks = 'in a city or fort'.

combat_factor(Element, 2, 2, Remarks) :-
	member(Element, ['LH', 'Ps']),
	Remarks = ''.

combat_factor(Element, 2, 0, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	Remarks = ''.


rear_support(3, Element, Against, Remarks) :-
	Element = 'Pk',
	any_foot(Against), Against \= 'Ps',
	Remarks = 'in close combat'.


rear_support(1, Element, Against, Remarks) :-
	Element = 'Wb',
	any_foot(Against), Against \= 'Ps',
	Remarks = 'in close combat'.

rear_support(1, Element, Against, Remarks) :-
	Element = 'Pk',
	member(Against, ['Kn', 'El', 'SCh']),
	Remarks = 'in close combat'.

rear_support(1, Element, Against, Remarks) :-
	Element = 'LH',
	any_troops(Against),
	Remarks = 'in close combat'.

rear_support(1, Element, Against, Remarks) :-
	member(Element, ['Kn', 'Cv', 'Sp', 'Bd', 'Bw']),
	any_foot(Against),
	Remarks = 'if is double element'.



flank_support(1, Element, Support, Remarks) :-
	Element = 'Sp',
	member(Support, ['Sp', 'Bd', 'CP', 'CWg', 'Lit']),
	Remarks = 'if both elements are solid foot'.

flank_support(1, Element, Support, Remarks) :-
	Element = 'Bw',
	member(Support, ['Bd', 'CP', 'CWg', 'Lit']),
	Remarks = 'if both elements are solid foot'.


flank_support(1, Element, Type, Support, Remarks) :-
	Element = 'Sp',
  Type = 'solid foot',
	member(Support, ['Sp', 'Bd', 'CP', 'CWg', 'Lit']),
	Remarks = 'if both elements are solid foot'.

flank_support(1, Element, Type, Support, Remarks) :-
	Element = 'Bw',
  Type = 'solid foot',
	member(Support, ['Bd', 'CP', 'CWg', 'Lit']),
	Remarks = 'if both elements are solid foot'.



tactical_factors(4, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'garrisoning a city or fort'.

tactical_factors(2, Element, Remarks) :-
	( Element = 'camp followers'; any_foot(Element) ),
	Remarks = 'defending a camp'.

tactical_factors(2, Element, Remarks) :-
	Element = 'city denizens',
	Remarks = 'defending a city'.

tactical_factors(1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'if is the general'.

tactical_factors(1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'in close combat upihll'.

tactical_factors(1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'in close combat defending a non-paltry river'.

tactical_factors(-1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'for each enemy element overlapping, or in contact in the flank or in the rear'.

tactical_factors(-1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'for each second or third enemy element aiding shooting'.

tactical_factors(-1, Element, Remarks) :-
	any_troops(Element),
	Remarks = 'for each additional element assauting a city, fort or camp, up to 2'.

tactical_factors(-2, Element, Remarks) :-
	any_troops(Element), not(member(Element, ['Ax', 'Bw', 'Wb', 'Ps'])),
	Remarks = 'in close combat in bad going'.


% outcomes

outcome('tie', Element, Against, Outcome, Remarks) :-
	any_troops(Element),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'attacking or defending a city, fort, or camp'.


outcome('tie', Element, Against, Outcome, Remarks) :-
	Element = 'SCh',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = ''.


outcome('tie', Element, Against, Outcome, Remarks) :-
	member(Element, ['Kn', 'Cm']),
	Against = 'Bd',
	Outcome = 'destroyed',
	Remarks = 'in close combat'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	member(Element, ['Kn', 'Cm']),
	Against = 'Bw',
	Outcome = 'destroyed',
	Remarks = 'in close combat if Lb or Cb'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	member(Element, ['Kn', 'Cm']),
	solid_foot(Against),
	Outcome = 'recoil',
	Remarks = 'against solid foot'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	Element = 'Kn',
	Against = 'Kn',
	Outcome = 'recoil',
	Remarks = '4Kn recoil against 3Kn in close combat'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	Element = 'Kn',
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, Against, Outcome, Remarks) :-
	any_mounted(Element),
	solid_foot(Against),
	Outcome = 'recoil',
	Remarks = 'against solid foot'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	any_mounted(Element),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, Against, Outcome, Remarks) :-
	fast_foot(Element),
	solid_foot(Against),
	Outcome = 'recoil',
	Remarks = 'fast foot recoil against solid foot'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	fast_foot(Element),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, Against, Outcome, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	solid_foot(Against),
	Outcome = 'recoil',
	Remarks = 'camp followers and city denizens recoil against solid foot'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, Against, Outcome, Remarks) :-
	member(Element, ['CP', 'CWg', 'Lit']),
	any_foot(Against),
	Outcome = 'destroyed',
	Remarks = 'in contact on 2 or more edges'.

outcome('tie', Element, Against, Outcome, Remarks) :-
	solid_foot(Element),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = ''.






outcome('lose', Element, Against, Outcome, Remarks) :-
	any_troops(Element),
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'if sacking a city'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	any_troops(Element),
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'if defending a city, fort or camp'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'sallied and in bad going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Mtd-',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'in bad going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	any_troops(Element),
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'in close combat against defenders of a city, fort or camp'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	member(Element, ['CP', 'Lit', 'CWg']),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = ''.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'El',
	member(Against, ['Ps', 'Ax', 'LH']),
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'El',
	Against = 'Art',
	Outcome = 'destroyed',
	Remarks = 'if shooting'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'El',
	Against = 'El',
	Outcome = 'flee',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'El',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'othewise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'SCh',
	ranged_troops(Against),
	Outcome = 'flee',
	Remarks = 'if shot at the front or the flank'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'SCh',
	any_troops(Against),
	Outcome = 'destroied',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Kn',
	member(Against, ['El', 'SCh', 'Cm', 'LH']),
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Kn',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cm',
	Against = 'SCh',
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cm',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'in bad going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cm',
	Against = 'El',
	Outcome = 'flee',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cm',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cv',
	Against = 'SCh',
	Outcome = 'flee',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cm',
	any_troops(Against),
	Outcome = 'flee',
	Remarks = 'in bad going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Cv',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	Against = 'SCh',
	Outcome = 'flee',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	Against = 'Art',
	Outcome = 'flee',
	Remarks = 'if shooting'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	any_troops(Against),
	Outcome = 'flee',
	Remarks = 'in bad going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	member(Element, ['Sp', 'Pk', 'Bd']),
	member(Against, ['Kn', 'SCh']),
	Outcome = 'destroyed',
	Remarks = 'in good going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	member(Element, ['Sp', 'Pk', 'Bd']),
	Against = 'Wb',
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	member(Element, ['Sp', 'Pk', 'Bd']),
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Ax',
	Against = 'Kn',
	Outcome = 'destroyed',
	Remarks = 'in good going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Ax',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Bw',
	any_mounted(Against),
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Bw',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Ps',
	member(Against, ['Kn', 'Cv', 'Cm']),
	Outcome = 'destroyed',
	Remarks = 'if winner in good going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Ps',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Wb',
	member(Against, ['Kn', 'SCh']),
	Outcome = 'destroyed',
	Remarks = 'in good going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Wb',
	any_troops(Against),
	Outcome = 'recoil',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Hd',
	member(Against, ['Kn', 'El']),
	Outcome = 'destroyed',
	Remarks = 'in good going'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Hd',
	Against = 'Wb',
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Hd',
	ranged_troops(Against),
	Outcome = 'recoil',
	Remarks = 'if shot at'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Hd',
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'WWg',
	Against = 'Art',
	Outcome = 'destroyed',
	Remarks = 'if shooting'.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'WWg',
	Against = 'El',
	Outcome = 'destroyed',
	Remarks = ''.

outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'WWg',
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('lose', Element, Against, Outcome, Remarks) :-
	Element = 'Art',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = ''.


outcome('double', Element, Against, Outcome, Remarks) :-
	any_troops(Element),
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'if defending a city, fort or camp'.


outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Cv',
	member(Against, ['Pk', 'Sp', 'Hd']),
	Outcome = 'flee',
	Remarks = 'in good going'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Cv',
	Against = 'Art',
	Outcome = 'flee',
	Remarks = 'in close combat'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Cv',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'otherwise'.


outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'in bad going'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	any_mounted(Against),
	Outcome = 'destroyed',
	Remarks = ''.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	Against = 'Art',
	Outcome = 'destroyed',
	Remarks = 'if shooting'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	member(Against, ['Bw', 'Ps']),
	Outcome = 'destroyed',
	Remarks = ''.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'LH',
	any_troops(Against),
	Outcome = 'flee',
	Remarks = 'otherwise'.


outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Ps',
	member(Against, ['Kn', 'Cv', 'Cm', 'LH']),
	Outcome = 'destroyed',
	Remarks = 'if winner in good going'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Ps',
	member(Against, ['Ax', 'Bw', 'Ps']),
	Outcome = 'destroyed',
	Remarks = 'in close combat'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Ps',
	member(Against, ['El', 'SCh']),
	Outcome = 'recoil',
	Remarks = 'in close combat'.

outcome('double', Element, Against, Outcome, Remarks) :-
	Element = 'Ps',
	any_troops(Against),
	Outcome = 'flee',
	Remarks = 'otherwise'.


outcome('double', Element, Against, Outcome, Remarks) :-
	any_troops(Element), not(member(Element, ['Ps', 'LH', 'Cv'])),
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = 'otherwise'.









outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	any_troops(Element),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'attacking or defending a city, fort, or camp'.


outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	Element = 'SCh',
	any_troops(Against),
	Outcome = 'destroyed',
	Remarks = ''.


outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	member(Element, ['Kn', 'Cm']),
	Against = 'Bd',
	Outcome = 'destroyed',
	Remarks = 'in close combat'.

outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	member(Element, ['Kn', 'Cm']),
	Against = 'Bw',
	Outcome = 'destroyed',
	Remarks = 'in close combat if Lb or Cb'.

outcome('tie', Element, _, Against, AType, Outcome, Remarks) :-
	member(Element, ['Kn', 'Cm']),
	solid_foot(Against),
  AType = 'solid foot',
	Outcome = 'recoil',
	Remarks = 'against solid foot'.

outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	Element = 'Kn',
	Against = 'Kn',
	Outcome = 'recoil',
	Remarks = '4Kn recoil against 3Kn in close combat'.

outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	Element = 'Kn',
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, _, Against, AType, Outcome, Remarks) :-
	any_mounted(Element),
	solid_foot(Against),
  AType = 'solid foot',
	Outcome = 'recoil',
	Remarks = 'against solid foot'.

outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	any_mounted(Element),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, Type, Against, AType, Outcome, Remarks) :-
	fast_foot(Element),
  Type = 'fast foot',
	solid_foot(Against),
  AType = 'solid foot',
	Outcome = 'recoil',
	Remarks = 'fast foot recoil against solid foot'.

outcome('tie', Element, Type, Against, _, Outcome, Remarks) :-
	fast_foot(Element),
  Type = 'fast foot',
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.

outcome('tie', Element, _, Against, AType, Outcome, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	solid_foot(Against),
  AType = 'solid foot',
	Outcome = 'recoil',
	Remarks = 'camp followers and city denizens recoil against solid foot'.

outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	member(Element, ['camp followers', 'city denizens']),
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'otherwise'.


outcome('tie', Element, _, Against, _, Outcome, Remarks) :-
	member(Element, ['CP', 'CWg', 'Lit']),
	any_foot(Against),
	Outcome = 'destroyed',
	Remarks = 'in contact on 2 or more edges'.

outcome('tie', Element, Type, Against, _, Outcome, Remarks) :-
	solid_foot(Element),
  Type = 'solid foot',
	any_troops(Against),
	Outcome = 'no effect',
	Remarks = 'solid foot suffer no effect otherwise'.


%

print_element(Element) :-
  findall(_, print_move(Element), _),
  findall(_, print_combat_factor(Element), _),
  findall(_, print_tie_outcome(Element), _),
  findall(_, print_winlose_outcome(Element), _),
  findall(_, print_double_outcome(Element), _).


print_element(Element, Type) :-
  findall(_, print_move(Element, Type), _),
  findall(_, print_combat_factor(Element, Type), _),
  findall(_, print_tie_outcome(Element, Type), _),
  findall(_, print_winlose_outcome(Element), _),
  findall(_, print_double_outcome(Element), _).


print_move(Element) :-
	format('Element: ~w~n', [Element]),
	move(Move, Element, Remarks),
  format('- Move: ~w, ~w~n', [Move, Remarks]).

print_move(Element) :-
	format('- Subsequent Moves~n'),
	subsequent_move(Element, Remarks),
	format('-- ~w~n', [Remarks]).

print_move(Element) :-
	format('- Interpenetration~n'),
	bagof(Move, bagof(Across, interpenetration(Move, Element, Across), ABag), MBag),
  ( member('recoil', MBag) *-> MStr = 'recoil into'; MStr = 'move or flee through' ),
  ( str_troops(ABag, STroops) ),
	format('-- ~w ~w~n', [MStr, STroops]).

print_combat_factor(Element) :-
	format('- Combat Factor~n'),
	combat_factor(Element, Foot, Mounted, Remarks),
	format('-- ~w vs. foot, ~w vs. mounted, ~w~n', [Foot, Mounted, Remarks]).

print_combat_factor(Element) :-
	format('- Rear Support~n'),
	bagof(Against, rear_support(Factor, Element, Against, Remarks), Bag),
  str_troops(Bag, Str),
	format('-- Gains ~w rear support vs. ~w, ~w~n', [Factor, Str, Remarks]).

print_combat_factor(Element) :-
	format('- Flank Support~n'),
	bagof(Support, flank_support(Factor, Element, Support, Remarks), Bag),
  str_troops(Bag, Str),
	format('-- Gains ~w flank support from ~w, ~w~n', [Factor, Str, Remarks]).

print_combat_factor(Element) :-
	bagof(Support, flank_support(Factor, Support, Element, Remarks), Bag),
  str_troops(Bag, Str),
	format('-- Gives ~w flank support to ~w, ~w~n', [Factor, Str, Remarks]).

print_combat_factor(Element) :-
	format('- Tactical Factors~n'),
	tactical_factors(Factor, Element, Remarks),
	format('-- ~w: ~w~n', [Factor, Remarks]).

print_tie_outcome(Element) :-
	format('- Combat Outcome:~n'),
	format('-- Tie:~n'),
	setof(Against, outcome('tie', Element, Against, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(1, Outcome, SOutcome),
	format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]).

print_tie_outcome(Element) :-
	setof(Against, outcome('tie', Against, Element, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(3, Outcome, SOutcome),
	( Outcome \= 'no effect' *-> format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]) ).

print_winlose_outcome(Element) :-
	format('-- Lose:~n'),
	setof(Against, outcome('lose', Element, Against, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(1, Outcome, SOutcome),
	format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]).

print_winlose_outcome(Element) :-
	format('-- Win:~n'),
	setof(Against, outcome('lose', Against, Element, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(3, Outcome, SOutcome),
	( Outcome \= 'no effect' *-> format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]) ).

print_double_outcome(Element) :-
	format('-- Double Lose:~n'),
	setof(Against, outcome('double', Element, Against, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(1, Outcome, SOutcome),
	format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]).

print_double_outcome(Element) :-
	format('-- Double Win:~n'),
	setof(Against, outcome('double', Against, Element, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(3, Outcome, SOutcome),
	( Outcome \= 'no effect' *-> format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]) ).




print_move(Element, Type) :-
	format('Element: ~w~n', [Element]),
	move(Move, Element, Type, Remarks),
  format('- Move: ~w, ~w~n', [Move, Remarks]).

print_move(Element, _) :-
	format('- Subsequent Moves~n'),
	subsequent_move(Element, Remarks),
	format('-- ~w~n', [Remarks]).

print_move(Element, _) :-
	format('- Interpenetration~n'),
	bagof(Move, bagof(Across, interpenetration(Move, Element, Across), ABag), MBag),
  ( member('recoil', MBag) *-> MStr = 'recoil into'; MStr = 'move or flee through' ),
  str_troops(ABag, Str),
	format('-- ~w ~w~n', [MStr, Str]).

print_combat_factor(Element, _) :-
	format('- Combat Factor~n'),
	combat_factor(Element, Foot, Mounted, Remarks),
	format('-- ~w vs. foot, ~w vs. mounted, ~w~n', [Foot, Mounted, Remarks]).

print_combat_factor(Element, _) :-
	format('- Rear Support~n'),
	bagof(Against, rear_support(Factor, Element, Against, Remarks), Bag),
  str_troops(Bag, Str),
	format('-- Gains ~w rear support vs. ~w, ~w~n', [Factor, Str, Remarks]).

print_combat_factor(Element, Type) :-
	format('- Flank Support~n'),
	bagof(Support, flank_support(Factor, Element, Type, Support, Remarks), Bag),
  str_troops(Bag, Str),
	format('-- Gains ~w flank support from ~w, ~w~n', [Factor, Str, Remarks]).

print_combat_factor(Element, Type) :-
	bagof(Support, flank_support(Factor, Support, Type, Element, Remarks), Bag),
  str_troops(Bag, Str),
	format('-- Gives ~w flank support to ~w, ~w~n', [Factor, Str, Remarks]).

print_combat_factor(Element, _) :-
	format('- Tactical Factors~n'),
	tactical_factors(Factor, Element, Remarks),
	format('-- ~w: ~w~n', [Factor, Remarks]).

print_tie_outcome(Element, Type) :-
	format('- Combat Outcome:~n'),
	format('-- Tie:~n'),
	setof(Against, outcome('tie', Element, Type, Against, _, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(1, Outcome, SOutcome),
	format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]).

print_tie_outcome(Element, Type) :-
	setof(Against, outcome('tie', Against, _, Element, Type, Outcome, Remarks), Set),
  str_troops(Set, Str),
  str_outcome(3, Outcome, SOutcome),
	( Outcome \= 'no effect' *-> format('---- ~w ~w, ~w~n', [SOutcome, Str, Remarks]) ).


%

subset([], _).
subset([H|T], List) :-
  ord_member(H, List),
  ord_subset(T, List).

equivalent(A, B) :-
  ord_subset(A, B),
  ord_subset(B, A).


str_troops(List, Str) :-
  findall(X, fast_foot(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ( equivalent(LSet, Set) *-> Str = "fast foot"; false ), !.

str_troops(List, Str) :-
  findall(X, solid_foot(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ( equivalent(LSet, Set) *-> Str = "solid foot"; false ), !.

str_troops(List, Str) :-
  findall(X, any_mounted(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ( equivalent(LSet, Set) *-> Str = "mounted troops"; false ), !.

str_troops(List, Str) :-
  findall(X, any_foot(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ( equivalent(LSet, Set) *-> Str = "foot troops"; false ), !.

str_troops(List, Str) :-
  findall(X, any_troops(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ( equivalent(LSet, Set) *-> Str = "any troops"; false ), !.


str_troops(List, Str) :-
  findall(X, fast_foot(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ord_subset(LSet, Set),
  ord_subtract(Set, LSet, Diff), length(Diff, DiffLen),
  ( (DiffLen =< 3, DiffLen > 0) *-> format(string(Str), "fast foot, except ~w", [Diff]); false ), !.

str_troops(List, Str) :-
  findall(X, solid_foot(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ord_subset(LSet, Set),
  ord_subtract(Set, LSet, Diff), length(Diff, DiffLen),
  ( (DiffLen =< 3, DiffLen > 0) *-> format(string(Str), "solid foot, except ~w", [Diff]); false ), !.

str_troops(List, Str) :-
  findall(X, any_mounted(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ord_subset(LSet, Set),
  ord_subtract(Set, LSet, Diff), length(Diff, DiffLen),
  ( (DiffLen =< 3, DiffLen > 0) *-> format(string(Str), "mounted troops, except ~w", [Diff]); false ), !.

str_troops(List, Str) :-
  findall(X, any_foot(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ord_subset(LSet, Set),
  ord_subtract(Set, LSet, Diff), length(Diff, DiffLen),
  ( (DiffLen =< 3, DiffLen > 0) *-> format(string(Str), "foot troops, except ~w", [Diff]); false ), !.

str_troops(List, Str) :-
  findall(X, any_troops(X), Bag),
  sort(List, LSet),
  sort(Bag, Set),
  ord_subset(LSet, Set),
  ord_subtract(Set, LSet, Diff), length(Diff, DiffLen),
  ( (DiffLen =< 3, DiffLen > 0) *-> format(string(Str), "any troops, except ~w", [Diff]); false ), !.




str_troops(List, Str) :-
  Str = List.



str_outcome(1, 'destroyed', 'destroyed by').
str_outcome(3, 'destroyed', 'destroy').
str_outcome(1, 'recoil', 'recoiled by').
str_outcome(3, 'recoil', 'cause to recoil').
str_outcome(1, 'flee', 'flee from').
str_outcome(3, 'flee', 'cause to flee').
str_outcome(1, 'no effect', 'suffer no effect from').
str_outcome(3, 'no effect', 'cause no effect to').
