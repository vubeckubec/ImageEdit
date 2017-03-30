#!/bin/bash
function kontrola {
f=`echo $cesta | awk -F "." '{print $2}' | awk -F " " '{print $1}'`
if [[ $f == "jpg" ]] || [[ $f == "png" ]] || [[ $f == "JPG" ]] || [[ $f == "PNG" ]] || [[ $f == "*" ]]; then
validni=1
else
validni=0
echo "Neplatna cesta k obrazku!"
fi
return $validni
}

function ending {
if [[ $volba == 1 ]]; then
end="jpg"
elif [[ $volba == 2 ]]; then
end="png"
fi
cesta2=`echo $cesta | awk -F "." '{print $1}'`
if [[ $volba == 1 ]]; then
konvertovat $cesta $cesta2.jpg
elif [[ $volba == 2 ]]; then
konvertovat $cesta $cesta2.png
fi
return
}

function kontrolaFormatu {
f=`echo $cesta | awk -F "." '{print $2}' | awk -F " " '{print $1}'`
if [ $volba == 1 ]; then
	if [[ $f == "png" ]] || [[ $f == "PNG" ]]; then
	validni=1
	else
	validni=0
	echo "Neplatny format obrazku!"
	fi
elif [ $volba == 2 ]; then
	if [[ $f == "jpg" ]] || [[ $f == "JPG" ]]; then
        validni=1
        else
        validni=0
        echo "Neplatny format obrazku!"
	fi
fi
return $validni
}

volba=55
until [ $volba == e ]; do
	validni=2
	echo "___Prosim vyberte si co byste chteli provest:___"
	echo "||||||||||||||||||||||||||||||||||||||||||||||||"
	echo "|					             |"
	echo "| (1) Zmena rozliseni			     |"
	echo "| (2) Pouziti efektu		             |"
	echo "| (3) Prevedeni na jiny format                 |"
	echo "| (4) Otocit			             |"
	echo "| (5) Zmenit kvalitu		             |"
	echo "| (Ctrl+c) Ukonceni                            |"
	echo "||||||||||||||||||||||||||||||||||||||||||||||||"
	echo "Vase volba: "
	read volba
	clear
	if [ $volba == 1 ]; then
		echo "Rozliseni"
		until [ $validni == 1 ]; do
		echo "Napiste svou cestu k obrazku prosim.: "
		read cesta
		kontrola
		done
		echo "Zvolte nove rozliseni pro vas obrazek: "
		read rozliseni
		konvertovat $cesta -resize $rozliseni $cesta
		echo "Rozliseni vaseho obrazku bylo zmeneno!"
	elif [ $volba == 2 ]; then
		echo "-----------------------------------|"
		echo "|Vyberte ktery efekt chcete pouzit |"
		echo "|					 |"
		echo "|	(c) Charcoal			 |"
		echo "| (i) Implosion			 |"
		echo "|----------------------------------|"
		echo "Vyberte jeden z efektu pro aplikovani: "
		read volba
		until [ $validni == 1 ]; do
		echo "Napiste svou cestu k obrazku prosim.: "
		read cesta
		kontrola
		done
		if [ $volba == c ]; then
			echo "Prosim zadejte silu efektu charcoal: "
			read sila
			konvertovat $cesta -charcoal $sila $cesta
			echo "Efekt charcoal byl aplikovan!"
		elif [ $volba == i ]; then
			echo "Prosim zadejte silu efektu implosion: "
			read sila
			konvertovat $cesta -implode $sila $cesta
			echo "Efekt implosion byl aplikovan!"
		fi
	elif [ $volba == 3 ]; then
		echo "Vyberte na ktery format chcete obrazek konvertovat"
		echo "(1) png -> jpg"
		echo "(2) jpg -> png"
		echo "--------------"
		read volba
		until [ $validni == 1 ]; do
		echo "Napiste svou cestu k obrazku prosim.: "
		read cesta
		kontrolaFormatu
		done
		ending
		echo "Obrazek byl uspesne konvertovan!"
	elif [ $volba == 4 ]; then
		echo "Rotovani obrazku"
		until [ $valid == 1 ]; do
		echo "Napiste svou cestu k obrazku prosim.: "
		read cesta
		kontrola
		done
		echo "Zadejte o kolik stupnu chcete obrazek otocit: "
		read rotace
		konvertovat $cesta -rotate $rotace $cesta
		echo "Obrazek byl uspesne otocen!"
	elif [ $volba == 5 ]; then
		echo "Zmena kvality"
		until [ $validni == 1 ]; do
		echo "Napiste svou cestu k obrazku prosim.: "
		read cesta
		kontrola
		done
		echo "Zvolte jak velkou kvalitu bude obrazek mit: "
		read kvalita
		konvertovat $cesta -kvalita $kvalita $cesta
		echo "Kvalita byla zmenena!"
	fi
done
