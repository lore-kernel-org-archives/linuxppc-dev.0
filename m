From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <linuxppc-commit@fsmlabs.com>, <linuxppc-dev@lists.linuxppc.org>,
	Cort Dougan <cort@fsmlabs.com>
Subject: Re: CPU features again
Date: Wed, 18 Apr 2001 18:47:53 +0200
Message-Id: <20010418164753.23516@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Those feature bits have to be common accross the entire PPC range (and
>> possibly common with ppc64 too since ppc64 is supposed to run ppc32
>> binaries, except that ppc64 has 32 more bits to stuff it's own features
>> for 64 bits binaries).
>
>BTW, we don't take the sparc64/mips64 approach and create arch/ppc64/?
>Sparc64/mips64 run 32-bit binaries as well.

I think we do, not sure, ask the IBM guys or paulus.

But the idea is to make sure the low 32 bits of features they expose to
userland via the asm/ppc64/elf.h (if they implement the HWCAP stuff)
are defined the same as ppc 32 bits.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
