Date: Wed, 27 Mar 02 10:53:14 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203271853.AA04719@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> The main problem I have with putting a "structure" inside one bi_rec like
> BI_GT64260_ETH_CFG is that it won't evolve. I mean, let's say today, you
> define it contains an HW ethernet address. Then, you figure out you have
> wired your PHY directly, it's not on the MII and you need your driver to
> know about it, how do you add that info ? Or you figure out that your
> driver would need some tunning (different LED wiring on the PHY), you
> change the structure layout to pass new parameters ?
> You create unnecessary compatibility hell.

OK, I accept that you are right, your flexible structure is better. Now are you
guys going to actually implement it or just talk about it?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
