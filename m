Message-ID: <015801c2a2c1$57fecf20$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: <acurtis@onz.com>, "Omanakuttan" <omanakuttan@tataelxsi.co.in>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <NCBBIINEHIPFGJPLBEIFAEBDEAAA.acurtis@onz.com>
Subject: Re: mcc support on mpc8260
Date: Fri, 13 Dec 2002 17:04:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I mean that by using the revision A.1 You could have some troubles.
Main reason is related to the Global Underrun (GUN) that often occours when
many channels are active (we use continuosly 64 channels on one mcc). This
issue has been repored by Motorola in its document "mpc8260cesumm.pdf" and
finally soved in the revision C.2 (6K23A)
Second issue, is related to the possibility of having a bit rotation into a
time slot. This problem has never been reported by Motorola but it seems to
be any more present in revisione C.2.

Regards

Gianfranco

----- Original Message -----
From: "Allen Curtis" <acurtis@onz.com>
To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>;
"Omanakuttan" <omanakuttan@tataelxsi.co.in>;
<linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, December 13, 2002 3:59 PM
Subject: RE: mcc support on mpc8260


>
> > Be aware do not use the mcc with the silicon revision older than B.1.
>
> Could you provide more information on this comment. There are lots of
> reasons not to use a rev A.1 chip. This is the first time that I heard
about
> using too new of a chip.
>
> THX
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
