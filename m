Message-Id: <200008021714.SAA12353@hyperion.valhalla.net>
Date: Wed, 02 Aug 2000 18:13:58 +0100
Subject: Re: Stealth port problems
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>So it looks like it's not getting enabled on New World machines.
>>After a brief look at the driver init code my impression (quite
>>possibly a wildly inaccurate one BTW) is that the driver wants DMA
>>channels and/or IRQs already partially configured.  On New World
>>machines booted via yaboot these may not be configured by OF.  On Old
>>World machines booted via BootX MacOS does the initialization.
>
> Can you all test with my rsync tree ? I changed the test against the
> number of addresses as Takashi pointed out. If it still doesn't work, we
> may have to add missing addresses "manually" (I hate OF tree fixup code ;)

yep. xxDMA show up OK on my Lombard now... sorr, can't test (I haven't
tangled with irDA and have no easy modem-based test).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
