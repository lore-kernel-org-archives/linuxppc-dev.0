Message-ID: <3B8242DD.C4D8EAF4@allot.com>
Date: Tue, 21 Aug 2001 14:15:41 +0300
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 vs RiskWatch
References: <20010821112325.3EC371125E@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> In message <3B8212A6.9AF31020@allot.com> you wrote:
> >
> > I have to convince our bosses to purchase BDI2000 for linux kernel
> > debugging.
> > Can someone please explain what BDI2000 can do that RiskWatch cannot.
>
> Just one question: does RiskWatch support the MMU?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "'Tis true, 'tis pity, and pity 'tis 'tis true."
> - Poloniouius, in Willie the Shake's _Hamlet, Prince of Darkness_

It seems so. This is what I've found in RISCWatch user manual:

RISCWatch support for MMU on the 400Series processors is subject to
adherence to the following conditions:

1. The translation mode for Data and Instruction access must be the same.
     They can both be enabled or disabled; having only one enabled is not
supported.

2. If the program execution is stopped at a point where the translation
mode has
     changed from the state existing upon initial load, then the mapping
must be
     real=virtual. If this is not the case, the source level debug
information for the
     stopped context will not be displayed correctly.

3. The real addresses in the TLB entries are assumed to be correct and
valid addresses.

Please excuse my ignorance: I assume that MMU support in debugger is
required to access
kernel virtual addresses. Is that correct ? Also what does this excerpt
from RISCWatch
manual tell you ? How can these RISCWatch "features" influence kernel
debugging.

Thanks a lot.

Felix.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
