Date: Tue, 25 Jul 2000 09:30:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jordan <ledzep37@home.com>
cc: Linuxppc Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Errors while compiling 2.4.0test5 from BitKeeper
In-Reply-To: <397CDA75.3790A3DB@home.com>
Message-ID: <Pine.LNX.4.10.10007250929510.16526-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> arch/ppc/kernel/kernel.o(.text+0x8ff8): relocation truncated to fit:
> R_PPC_REL24 pmu_request
> arch/ppc/kernel/kernel.o(.text+0x9008): undefined reference to
> `pmu_poll'
> arch/ppc/kernel/kernel.o(.text+0x9008): relocation truncated to fit:
> R_PPC_REL24 pmu_poll
> make: *** [vmlinux] Error 1

Include PMU support.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
