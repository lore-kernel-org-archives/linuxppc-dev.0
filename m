Message-ID: <3874CE29.C4E19A44@crf.canon.fr>
Date: Thu, 06 Jan 2000 18:17:29 +0100
From: Eric Valette <valette@crf.canon.fr>
MIME-Version: 1.0
To: Matt Porter <mmporter@home.com>
CC: Cort Dougan <cort@fsmlabs.com>, Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com> <20000105164119.C20193@cx258813-a.chnd1.az.home.com> <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr> <20000106101041.A27148@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> > Just to tell you that :
> >
> >         1) I applied the 2.2.14pre4 prepide-patch on a clean
> >         linux 2.2.14 tree. Effectively the ppc part is in and
> >         not the ide-pci.c, ide-probe.c, and sl82c105.c
> >         2) BUT : after applying the missing part of the patches
> >         the behavior is absolutely identical!!!
> >
> > hdc : lost interrupt...
> >
> > any other hints?
> 
> Since you have the old defective MCP750, you can either return it or apply
> the 99% workaround of reprogramming the level/edge triggering on the VIA as
> you've done before.  The patch does work on all MCG IDE capable hardware
> except the revs of the MCP750 that should no longer be used by customers.

No. That is not so simple : I have also a REV D board that behaves
exactly
the same way. If you want I can send you my .config file and the binary.
Also remember that I managed to have the same linux 2.2.10 image 
to run on both platforms...

-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
