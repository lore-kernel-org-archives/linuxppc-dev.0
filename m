Message-ID: <39BF773E.A5A3D298@univ-rennes1.fr>
Date: Wed, 13 Sep 2000 13:46:54 +0100
From: Martin Costabel <costabel@univ-rennes1.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Martin Costabel <costabel@wanadoo.fr>, toa@pop.agri.ch,
        Paul Mackerras <paulus@linuxcare.com>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: success 2.4.0-test8 with latest bk
References: <Pine.LNX.4.10.10009130011300.372-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Tue, 12 Sep 2000, Martin Costabel wrote:
> > Andreas Tobler wrote:
> > > I want to express my thanks to you including Geert's pci-res patch, now
> > > I'm able again to run the latest devel tree from bk on my ancient 7200
> > > with it's 2940UW.
> > > It is running since three h.
> >
> > You are lucky. For me it stops booting after the "freeing unused kernel
> > memory" line. The one from 2 days ago had 2 days uptime.
>
> Usually this means that some function/data is marked __init while it must not.
> Quick verification: #undef __init / #define __init etc.
>
> Just wondering: wouldn't it be possible to write some tool to find such bugs?

Update: After a recompilation with today's updates, the latest bk kernel
boots again for me.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
