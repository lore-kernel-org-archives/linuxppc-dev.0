Date: Mon, 10 Feb 2003 16:28:54 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 3
In-reply-to: <3E47BC5E.2010903@intracom.gr>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGECDFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >Hi Pantelis
> >
> >I don't follow you here. Didn't my patch apply cleanly against linuxppc_2_4_devel?
> >I generated my patch against linuxppc_2_4_devel(I think).
> >
> >    Jocke
> Nope.
>
> Fails at hunks #7 and #8.
> Don't worry, it's trivial stuff.
>
> Here is enet.c.rej, if you want to check it.

hmm, something is broken here. I can apply my patch to my local copy of
8xx_io/enet.c, BK version 1.24 just fine. Whats your version of enet.c?

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
