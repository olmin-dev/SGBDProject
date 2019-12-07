Create view Nombre_de_cartes_par_joueur as(
  Select JOUEURS.ID_JOUEUR, JOUEURS.NOM_JOUEUR, JOUEURS.PRENOM_JOUEUR, JOUEURS.PSEUDONYME,
  count(POSSESSIONS_EXEMPLAIRES.ID_EXEMPLAIRE) as TOTAL
  from POSSESSIONS_EXEMPLAIRES
  INNER JOIN JOUEURS on JOUEURS.ID_JOUEUR = POSSESSIONS_EXEMPLAIRES.ID_JOUEUR
  group by JOUEURS.ID_JOUEUR, JOUEURS.NOM_JOUEUR, JOUEURS.PRENOM_JOUEUR, JOUEURS.PSEUDONYME
);

Create view Classement_joueurs as (
  Select ID_JOUEUR, NOM_JOUEUR, PRENOM_JOUEUR, PSEUDONYME,
  sum((EXEMPLAIRES.QUALITE/100)*APPARTENANCES.COTE) as VALEUR
  from JOUEURS
  natural join POSSESSIONS_EXEMPLAIRES
  natural join EXEMPLAIRES
  natural join APPARTENANCES
  group by ID_JOUEUR, NOM_JOUEUR, PRENOM_JOUEUR, PSEUDONYME
  order by VALEUR desc
);

Create view Cartes_par_joueur as(
  Select CARTES.TITRE, sum(DECKS.ID_JOUEUR) AS NOMBRE_UTILISATIONS from (CARTES
  join CONTENANCE on CARTES.ID_CARTE = CONTENANCE.ID_CARTE)
  join DECKS on CONTENANCE.ID_DECK = DECKS.ID_DECK
  group by CARTES.TITRE
);

Create view Joueur_rare as(
Select JOUEURS.NOM_JOUEUR, count(JOUEURS.NOM_JOUEUR) AS NB_RARE from (JOUEURS
join POSSESSIONS_EXEMPLAIRES on POSSESSIONS_EXEMPLAIRES.ID_JOUEUR = JOUEURS.ID_JOUEUR)
join EXEMPLAIRES on EXEMPLAIRES.ID_EXEMPLAIRE = POSSESSIONS_EXEMPLAIRES.ID_EXEMPLAIRE
where EXEMPLAIRES.ID_CARTE in
(Select CARTES.ID_CARTE from CARTES
  join APPARTENANCES on APPARTENANCES.ID_CARTE = CARTES.ID_CARTE
  where APPARTENANCES.NB_TIRAGE <= 100) OR EXEMPLAIRES.DATE_IMPRESSION <= '01-JAN-2000'
group by JOUEURS.NOM_JOUEUR
order by NB_RARE DESC
);
