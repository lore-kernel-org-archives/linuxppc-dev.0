To: Erik Kunze <Erik.Kunze@philosys.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pppd/pppoed 
In-reply-to: Your message of "Fri, 27 Oct 2000 10:32:34 +0200"
             <20001027103234.A24109@nphilos.philosys.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Date: Fri, 27 Oct 2000 20:59:20 +1100
Message-ID: <22087.972640760@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22066.972640685.1@msa.cmst.csiro.au>

On Fri, 27 Oct 2000 10:32:34 +0200, Erik Kunze <Erik.Kunze@philosys.de> writes:
>I'm trying to port pppd and pppoed to a MPC860T based embedded board
>using Hard Hat 1.2 for cross developement. Unfortunately both packages
>aren't designed for cross compiling.
>
>Did anyone already port these programs to embedded Linux/PPC?

Here are my diffs to ppp-2.3.11 - after applying the patches, run

    ./configure Linux
    make CC=<cross>-gcc INCLDIR=<crossdir>/include LIBRDIR=<crossdir>/lib all

where <cross> is your cross compiler prefix e.g. powerpc-linux, and <crossdir>
is the location of your cross compiler include and library files - something
like /opt/powerpc/<cross>. Probably not a good idea to try to run the "install"
target without setting DESTDIR.

I cross-compile under Solaris 2.7, but it should work for Linux-x86 ->
Linux/PPC also (in fact, because both are linux, you probably don't need the
"Linux" arg to "./configure").

Standard caveat applies - I wrote this message all from memory, check it
out yourself before you run it to be sure that it does what I think it does.
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


------- =_aaaaaaaaaa0
Content-Type: application/x-gzip
Content-ID: <22066.972640685.2@msa.cmst.csiro.au>
Content-Transfer-Encoding: base64

H4sICCxO+TkCA3BwcC0yLjMuMTEtZGlmZnMAtVZtc6JIEP4cfkVv4oe4iDD4EmUrVyHqRrZ8oYK5
7NXdlevKmFCLwPKSS/799QwgipituqpLGRjop6e7n266R5IkaMrr51UsT1c/6MZxadN1vORVsp0o
PvscOqAnT0BaQIjWaWstFUi/3xdEUazW4yoWDYB08Ke1FQ11VUVRhJsbkFSlcQUiv97cCCCA40Xx
ynU1YFsJcLb9YTshSAHULm+N2dC4rwvSWe3SmFkLfTKpgxSBtObgPYR4gDgSQ0ksbaHbbnNUs4e4
qc5x8nbl9ZhPa5euPE2QODVBENiV1CyeExjSNahIjaqpLU252qemQq9MDdGIUlDTanRBbDWQLcbM
BdQMW4PDDRovQJqtDjcjE1VG0wrJTAerxE0iGL0idaiOcYjOxrPpBibG7T3GJ4jZAq5BTqJQdp3v
gkg929nsoMZsMOHQbJFDHW/tJjbdwZl/Q7pBk3GewVXs+B64/povIgFS9vMdou+OJ0DKdP4O+U6L
os+KotXNimIwNxcWYqS5ioXgBBSkRzQA0pPAYkERBiehx/QnXNYu/3Fce70K7V1Q7H8dvgVx82O9
UeexlZC1y4yKegmb7i+ibZe/FSANGNIMXTVID8R2m93SJE0taTDWTVgl8TP1YieNHoLQj/217zYx
GhRPres3AR6s0XJw/4e5wIf/yf2x/ntmYzlmJnPvka+xbi2tsT6cP6JAvDh4hAvmm6lP+ZpvYsxG
iy57FMCcPNwZM76WWF08DEdLNG4hS0azWdTGaRlITvQWxXQL7EPklVVnOw/mU9OYjJafJ/odUxku
eZkvrwmuuRumvhhbyzE+GubXJXI5uxtl2ejyVtK9yqqGZ479aSx7No1Smiw0RN2IojFuBQEsvcMi
GeRkMjLv5ZTh55PZyEPaB5bMHSSG7BKT3lg0RMGqUkAkhLA7iyhrWdf5FwaSD6Hvxwdtk7UZ7JDH
bbPoa1UNFFtgu9NRuHqhI2e7ORv4gO3xKQwYIIloGJVAoP4m2/RF9hLX/QSs9uEvVATU2vo2+GL4
WtL4BBsHG/V7jqYNWDzu1iddFS/+q6+o+StnK8ZGG8cGk1eODSbQ8L1pmsP57ResvGKCJNugcohM
sVl8SVxQu6ASTelrar88RI5Vj+cIU8/nCGk1OlhH7Ho4YiunazmOilrJnHhn3h4j3uEOgcf07ZhC
V+OokqpHauM4DEHFoFsaskU4Vb2CqirdY67a+1z1WA/hV8ZV/kXxjcqfWfqymh8uO6yhFF7B1Ens
ac64/Ig0uZBk5cefshLEfRbW/WBXhWvf2zhPSUiLwpv5L5wWVet0WQntH+xydIk/ta+R9h5/nL5G
P52GH2Qc8nL0vDu97HbhBxd2UOIHFyLjZnhwSa0eHlxYM4Y/QcIWPKOvsY5Bwd/pV8uaL4pqF3gS
iEEpXgOk0+X6vEbO8Yzint4CCuyMfl1YMQ3O8wGxE31LvNUWh1b0TfgXj4gBnB8LAAA=

------- =_aaaaaaaaaa0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
