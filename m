Date: Fri, 12 Oct 01 11:21:30 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110121821.AA00783@ivan.Harhan.ORG>
To: paulus@samba.org, trini@kernel.crashing.org
Subject: Re: boot methods
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> All of the 7xx/74xx/8240 boards in _devel boot via zImage.<board> from
> network/disk/flash, depending.

Except those that boot via ppc-linux-boot. Adirondack can boot only via ppc-
linux-boot and has no zImage in any shape or form, K2 can boot either via
StarMON/ppc-linux-boot or via PMON/zImage.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
