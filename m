Message-Id: <v04003a06b8e101c94b83@[24.70.162.28]>
In-Reply-To: <Pine.BSF.4.44.0204151224090.39853-100000@shell.unixbox.com>
References: <p05100303b8e0cf886762@[63.220.231.138]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 15 Apr 2002 17:25:21 -0500
To: Ani Joshi <ajoshi@shell.unixbox.com>,
	Stefan Jeglinski <jeglin@4pi.com>
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:27 PM -0500 4/15/02, Ani Joshi wrote:
>On Mon, 15 Apr 2002, Stefan Jeglinski wrote:
>
[...]
>> 1. Is the Radeon 7000 supported in XFree86? Rather, the real question
>> is, does anyone know of any gotchas trying to run it in accelerated
>> mode?
>
>ATI tends to make new cards which are really just newer revisions of older
>ASICs.  For example, the Radeon 7200 is realy just a regular radeon with
>64meg DDR (and perhaps higher clocks).  So its highly possible that the
>7000 is a radeon VE (considering its dualhead).  If so, then it is
>supported.  Even if it isn't, adding support should be very trivial as it
>contains the same 1st generation Radeon ASIC.
[...]

In the PC version, the Radeon7000 is exactly identical to the RadeonVE,
except it only has analog VGA out, no DVI (I happen to have one in my l33t
athlon). This makes things extra confusing, since the Radeon7000 Mac
Edition actually does have a DVI connector and TV-out.

I'm pretty sure that the entire Radeon, RadeonVE and Radeon 7*00 series are
based on the same R100 chip, with different clocks, connectors, ram, and
features enabled. The Radeon8500, on the other hand, has the newer R200
chip, and I think an R300 'Radeon9500' is in the works.

You'll have to remember, though, that even with the nice internal
performance of the Radeon7000, running two displays on one 32/33 PCI card
will definatley be pushing the bandwidth limits, so performance may not be
100%.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
