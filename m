Date: Thu, 22 Jul 1999 08:01:11 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: VALETTE Eric <valette@crf.canon.fr>
cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, mmporter@home.com,
        jpeters@phx.mcd.mot.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Is the vger 2.2 kernel branch dead
In-Reply-To: <m117EQ0-0000WZC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.4.10.9907220749570.10882-100000@fwrsl-11.phx.mcd.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Jul 1999, VALETTE Eric wrote:

> >>>>> "Geert" == Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> writes:
> 
> Geert> AFAIK Cort is not on vacation. He checks in patches at vger on a daily base.
> 
> So why did I get no single comment on patches I submitted?
> The Prep IDE handling is broken...

Define "PReP IDE handling is broken" because it isn't broken on systems
that use only the legacy PIC.  I only see breakage on MPIC Mot. systems
here with positive results on PowerStacks etc...

I assume you are referring to the MCP750 level inversion problem for one.
The other problem is how the pci-ide driver snags interrupt 16 from the
PIB config space on all Mot. Raven/Hawk boards as the IDE interrupt.  I've
got patches for these things. They are not in the patch that Johnnie sent
in because there is an outstanding issue of the MTX IDE driver hanging on
the partition check that I would like to fix as well (even though nobody
should be using IDE if they paid for an MTX :).

--
Matt Porter                                       Motorola Computer Group
matt_porter@mcg.mot.com                           CIBU Linux Support


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
