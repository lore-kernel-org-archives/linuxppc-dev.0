Message-Id: <199906230641.BAA10268@lists.linuxppc.org>
Date: Wed, 23 Jun 1999 08:40:52 +0200 (CEST)
From: laures@esiea.fr
Subject: Re: preferred Sync rates in X for PDQ/Wallstreet 2.0
To: jpgarcia@execpc.com
cc: linuxppc-dev@lists.linuxppc.org,
        fr.comp.os.unix.mac@Jaws.gom.cybercable.fr
In-Reply-To: <Pine.GSO.3.95.990622132502.21035A-100000@earth>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22 Jui, Joseph Palani Garcia wrote:
> 
> Does anyone know the preferred HorzSync and VertRefresh rates for the LCD
> display on a PBG3/300?

>From my /etc/X11/XF86Config file:

# **********************************************************************
# Monitor section
# **********************************************************************

# Any number of monitor sections may be present

Section "Monitor"

    Identifier	"WallStreet built-in LCD Panel"
    VendorName	"Apple"
    ModelName	"14,1 TFT"

    HorizSync   48.115

    VertRefresh 59.696

    Mode "1024x768"
        DotClock	64.666
        HTimings	1024 1032 1176 1344
        VTimings	768 771 777 806
    EndMode

EndSection

...

works like a charm on my PBG3 292, I took these values from fbset.

french version: 
voici les valeurs a inserer dans le fichier /etc/X11/XF86Config pour un
fonctionnement optimal de l'ecran LCD 14,1 ' des PB G3 Series. Elles on
ete obtenues a partir du programme fbset

-- 
Guillaume Laurès - student @ ESIEA (www.esiea.fr)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
