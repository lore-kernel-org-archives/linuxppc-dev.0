Date: Thu, 24 Oct 2002 09:14:13 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c
In-reply-to: <02102313323200.01073@scop.digitel.com.br>
To: Ricardo Scop <scop@digitel.com.br>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEFFFHAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > >
> > > Comments? Anyone care to do some benchmarking?
> >
> > No comments so far, no one interested in this?
> I'm interested! Indeed, I adapted and tested your patch in a 8260 FCC fast
> ethernet driver and it worked fine  I had a 20% increase in routing
> throughput with the  patch installed!

Cool!

>
> The bug fix in set_multicast_list worked too. But, since there's a continue
> clause inside the for command in this routine, I would suggest that the
> (dmi=dmi->next) command go inside the for increment clause, instead of the
> place you've put it; that is:
> 	for (...;...; i++, dmi = dmi->next) {...}

Yes thats better, thanks.
> >
> > A question, why do enet.c pass bad frames to netif_rx? Only late collisions
> > are disregarded, the rest is passed on.
> IMHO, this is another bug...
me too.

       Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
