Date: Fri, 10 Mar 2000 20:21:26 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
   cwithr128
In-Reply-To: <v03110700b4eeeb194579@[129.100.29.243]>
Message-ID: <Pine.LNX.4.10.10003101940550.9648-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi Kostas,
>
> >> So we should probably get some official patch out there that includes a few
> >> elements:
> >>
> >
> >  What do you mean by official ? The next xfree86 update will have
> >this fix what more official do you suggest ?
> >
> >> 1. Either:
> >>        - user defined cache line size during compile
> >>    or:
> >>        - flush a cache range in address increments of 8
> >>
> >> to handle the variable line cache size
>
> I am confused.  Now that XF 4.0 is out, will quick snapshots continue to be
> released?

One would sure hope so. The 4.0 X server dies horribly during device
configuration on my Lombard. After feeding it a hand-crafted XF86Config,
it just hangs the machine.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
