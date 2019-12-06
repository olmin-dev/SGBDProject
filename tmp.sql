Select JOUEURS.NOM_JOUEUR from JOUEURS
join POSSESSIONS_EXEMPLAIRES on POSSESSIONS_EXEMPLAIRES.ID_JOUEUR = JOUEURS.ID_JOUEUR
where POSSESSIONS_EXEMPLAIRES.ID_CARTE in
(Select CARTES.ID_CARTE from CARTES
  join APPARTENANCES on APPARTENANCES.ID_CARTE = CARTES.ID_CARTE
  where APPARTENANCES.NB_TIRAGE <= 100)
;
