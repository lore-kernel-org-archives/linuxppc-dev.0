From: Peter Bergner <bergner@borg.umn.edu>
Date: Thu, 19 Apr 2001 13:24:46 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
	Cort Dougan <cort@fsmlabs.com>
Subject: Re: CPU features again
Message-ID: <20010419132446.A11105@brule.borg>
References: <Pine.LNX.4.05.10104181835150.5185-100000@callisto.of.borg> <20010418164753.23516@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010418164753.23516@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>>> Benjamin Herrenschmidt wrote:
>>> Those feature bits have to be common accross the entire PPC range (and
>>> possibly common with ppc64 too since ppc64 is supposed to run ppc32
>>> binaries, except that ppc64 has 32 more bits to stuff it's own features
>>> for 64 bits binaries).
>>
>> Geert Uytterhoeven wrote:
>> BTW, we don't take the sparc64/mips64 approach and create arch/ppc64/?
>> Sparc64/mips64 run 32-bit binaries as well.
>
> I think we do, not sure, ask the IBM guys or paulus.

Yes, we will have an arch/ppc64/ subtree.  Although we can run unmodified
32-bit user programs, there were enough changes to the kernel to warrent
the split.

On a related subject, we're still trying to figure out what to do
with the "uname -m" thing (ie, ppc vs ppc64) and its use in configure
scripts, rpm,...



Benjamin Herrenschmidt wrote:
: But the idea is to make sure the low 32 bits of features they expose to
: userland via the asm/ppc64/elf.h (if they implement the HWCAP stuff)
: are defined the same as ppc 32 bits.

I haven't thought about the feature bits, let alone looked into it.


Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@us.ibm.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
