Message-ID: <3BBBA395.3B812898@india.infogain.com>
Date: Thu, 04 Oct 2001 05:17:33 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: "Prasad, Siva" <Siva.Prasad@smartm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: EPIC <=> OpenPIC
References: <35C119252057D511BB9F0003476BF8A208E5DB@freexc01.smartm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yah..it is already available.
Epic has been ported for MPC 107 and MPC 106 as well.
for mpc 106 can refer montavista port .
I assume we have for mpc107 and 750 board.
I will find that and would give you for refrence.
you can't use directly openpic structure as there is small deviation.
try to adjust your openpic structure as per epic manual.
set appropiately the triggering and polarity mode for irq lines
from winbond bridge and for shared pci slots.
refer the epic chapter and eumbbar chapter (for epic base)
in MPC 107 manual for correct programming

> Is there code written or ported to EPIC (Embedded programmable interrupt
> controller - MPC 107)?.
>
> EPIC is adopted from OpenPIC.
>
> Our PPC 750 based board uses MPC107 as PCI bridge, and direct interrupts.
> Since I can't use OpenPIC directly, it would be great if some one can share
> the code for EPIC.
>
> If it is already available some place... I would appreciate the pointer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
