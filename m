Message-ID: <3CB5B0E9.16F06226@mvista.com>
Date: Thu, 11 Apr 2002 11:51:05 -0400
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
References: <0204111616.AA28753@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> but not StarMON. I remember problems of that sort on K2. Also in your current
> EV-64260 port the wrapper assumes that the GT registers are at 0x14000000,
> while StarMON puts them at the much more reasonable 0xF1000000. But I did
> indeed boot your EV-64260 zImage from StarMON, I just wrote a tiny program that
> remaps the GT registers back to 0x14000000 and jumps to 0x800000 where zImage
> lives. (I also had to comment out a few things in the Linux code proper in your
> wonderful EV-64260 port that prevented it from running on my board, but that's
> beside the point here.)

Yes, it assumes the registers are at 0x14000000 because that's where DINK leaves
them.  It was made clear from the start that the arch/ppc/boot code for the
ev64260 was built for boards running DINK.

When we see what Benh has for bi_recs, we can start making this more general.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
