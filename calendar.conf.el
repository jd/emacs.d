(setq calendar-week-start-day 1)	; Weeks start on monday
(setq calendar-date-style 'european)

(setq european-calendar-style t)

(setq calendar-legal-holidays
      '((holiday-fixed 1 1 "New Year's Day")
        (holiday-fixed 5 1 "Fête du Travail")
        (holiday-fixed 5 8 "Armistice 1945")
        (holiday-fixed 7 14 "Fête National")
        (holiday-fixed 8 15 "Assomption")
        (holiday-fixed 11 1 "Toussaint")
        (holiday-fixed 11 11 "Armistice 1918")
        (holiday-fixed 12 25 "Christmas")
        (holiday-easter-etc 1 "Lundi de Pâques")
        (holiday-easter-etc 39 "Ascension")
        (holiday-easter-etc 50 "Lundi de Pentecôte")))

(setq calendar-celebration-holidays
      '((holiday-fixed 2 2 "Chandeleur")
        (holiday-fixed 2 14 "Fête des amoureux")
        (holiday-float 3 0 1 "Fête des grands-mères")
        (holiday-fixed 3 17 "St. Patrick's Day")
        (holiday-fixed 4 1 "April Fools' Day")
        (holiday-float 5 0 -1 "Fête des Mères")
        (holiday-float 6 0 3 "Fête des Pères")
        (holiday-fixed 6 21 "Fête de la musique")
        (holiday-fixed 10 31 "Halloween")
        (holiday-easter-etc -47 "Mardi Gras")))

(setq calendar-holidays
      `(,@holiday-solar-holidays
        ,@calendar-legal-holidays
        ,@calendar-celebration-holidays))
