Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Wed, 20 Mar 02 09:11:10 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203201711.AA10183@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> wrote:

> I'm getting a bit tired about this discussion.

I got tired a long time ago.

> We  start  with  siome
> nice  ideas,  then  some open issues pop up, and instead of trying to
> find a solution we drop everything again.
                  ^^^^^^^^^^^^^^^^^^^^^^^^^

No, we don't drop everything again, there is my patch, and Mark said he'll push
it if there is no consensus in the next few days, which I've already bet $50
on.

> For instance. Hey, but we are talking about a very, very special case
> here - when you have set of non-standard controllers which don't know
> their own addresses _and_ need to get a specific assignment _and_ you
> don't know the initialization sequence _and_ ...
>
> For 98% of all practical purposes it will be sufficient to  pass  the
> list of MAC addresses, and for 1.95% it will be sufficient to combine
> the  MAC  address  with  information about the driver type (GT, 82xx,
> ...).

But this is lousy logic, it's this kind of logic (it's OK for 98% of cases)
that has given us the crap we have right now.

Just what is wrong with my solution of BI_GT64260_ETH_CFG, BI_8260_ETH_CFG,
BI_8XX_ETH_CFG, etc?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
