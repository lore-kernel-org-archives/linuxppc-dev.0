Date: Thu, 4 Mar 2004 10:18:11 +0100 (CET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: early return set_multicast
In-Reply-To: <200403031601.28119.scop@digitel.com.br>
Message-ID: <Pine.LNX.4.44.0403041013290.1901-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 3 Mar 2004, Ricardo Scop wrote:

> Hi,
>
> On Wednesday 03 March 2004 13:09, Jaap-Jan Boor wrote:
> > Hi,
> >
> > does somebody know why there is an early return;
> > statement in the set_multicast_list() function
> > of 8260_io/fcc_enet.c (or cpm2_io/fcc_enet.c)?
> >
>
> [snip]
>
> Well, probably the code after the early return is broken ;).

that's what I was afraid for yes

> Which kernel version is that?

all I checked (denx latest 2.4.24-pre2, bk linuxppc 2.4.26-pre1
and kernel.org 2.4.22)

> There used to be at least one bug
> in the for statement (lack
> of a dmi=dmi->next statement inside it, AFAIR).


thanks again.

Jaap-Jan

>
> >
> > thanks,
> >
> > Jaap-Jan
>
> Your welcome.
>
>

--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
