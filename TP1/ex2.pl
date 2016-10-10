piloto(lamb).
pilot(beseney).
piloto(chambliss).
piloto(macLean).
piloto(jones).
piloto(bonhomme).

equipa(lamb,breitling).
equipa(beseney,redbull).
equipa(chambliss,redbull).
equipa(maclean,mediterranean).
equipa(mangold,cobra).
equipa(jones,matador).
equipa(bonhomme,matador).

aviao(mx2,lamb).
aviao(edge540,beseney).
aviao(edge540,chambliss).
aviao(edge540,maclean).
aviao(edge540,mangold).
aviao(edge540,jones).
aviao(edge540,bonhomme).

circuito(istanbul).
circuito(budapest).
circuito(porto).

venceu(porto,jones).
venceu(budapest,mangold).
venceu(istanbul,mangold).

gates(istanbul,9).
gates(budapest,6).
gates(porto,5).

ganha(Equipa, Circuito):- equipa(Piloto, Equipa), venceu(Piloto, Circuito).