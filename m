Message-ID: <3A71946D.C98063EB@agelectronics.co.uk>
Date: Fri, 26 Jan 2001 15:14:53 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Query: PCI and Ethernet hardware/drivers
References: <B25E2E5A003CD311B61E00902778AF2A0148B69D@server1.skystream.com> <3A718D21.66F9227D@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Roberts wrote:

> 1) Does Linux/PPC handle the PCI bus properly?

Short answer, yes. Long answer, how strange a PCI system do you want to
build?

> 2) Are there Linux/PPC drivers for the PLX 9054 (PCI interface) chip?
>    (Yes, that is PPC 60x-bus, not MAX bus; the hardware will handle that)

I ported the 2.2 kernel to a board which used the very similar PLX 9080.
Does this mean that your board is intended to be a PCI agent? If so,
you've got a whole world of fun ahead of you, and you can ask me for
more details.

> 3) What Ethernet MAC chips have people had success using?
>    (right now we favor an AMD chip, which they claim has Linux drivers,
>    but their test plan includes only AMD and Intel CPUs, not PowerPC)

I've used a fully integrated AMD part.  Works fine, even if it's not the
world's cleverest ethernet chip.

> 4) We favor a 4-CPU SMP configuration. What not-so-obvious problems
>    are we likely to face? (e.g. our simulations show that doing this
>    at 133 MHz cannot be done using a CPLD-based memory controller:
>    wimpy data-bus drivers (:-() Our existing boards are all non-SMP,
>    and bus snooping is a bit of a mystery to us....

Designing a good interrupt controller.

- Adrian Cox

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
