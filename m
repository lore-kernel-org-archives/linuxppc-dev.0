Date: Tue, 21 Nov 2000 08:10:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: whacked out 2.2.18preX - last gasp
Message-ID: <20001121081013.G552@opus.bloom.county>
References: <p04330100b63f9bce42dd@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p04330100b63f9bce42dd@[192.168.0.1]>; from jeglin@4pi.com on Mon, Nov 20, 2000 at 11:03:43PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 20, 2000 at 11:03:43PM -0500, Stefan Jeglinski wrote:

> 	ERROR - Attempting to write value for
> 	unconfigured variable (CONFIG_SERIAL_CONSOLE).
>
> when using make xconfig. I can't see how this could be related, but it is true.

xconfig is buggy sometimes.  Try make oldconfig afterwards, it'll prompt for
anything which didn't get set by xconfig.

> It's frankly hard at this point to buy that one of my PCI devices is
> walking over the kernel. Or if it is, it looks like the end of the
> Linux line for my PowerTowerPro with the 2940 card. I think this is
> either a bug in the aic7xxx driver that has been exposed by 2.2.18
> changes (highly doubtful, there are too many 2940s out there for it
> to have been missed), or a linux-pmac bug. I just don't know enough
> yet to prove it, much less find it.

Hmm.  2.2.18pre21 from linuxppc_2_2 bk works on my G4/Yikes! with a 2940UW
in it.  What compiler are you using?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
