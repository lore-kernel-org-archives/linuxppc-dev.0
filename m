Message-ID: <3BAA4F46.1020002@mc.com>
Date: Thu, 20 Sep 2001 16:19:18 -0400
From: Mark Salisbury <mbs@mc.com>
MIME-Version: 1.0
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <20010920171002.37DCA2B54A@marcus.pants.nu>	<3BAA363B.5010400@mc.com> <8xlmj9psnw.fsf@s62.informatik.uni-bremen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag wrote:

> Mark Salisbury <mbs@mc.com> writes:
>
> [... linux in ppc little endian mode ...]
>
>>well, this is in the context of a multi-CPU type (x86/ppc, sparc/ppc,
>>ppc/ppc, mips/ppc) shared memory multicomputer.
>>
>>when dealing w/ direct mapped, shared memory, uniformity of endian-ness
>>makes many multicomputer problems easier to solve.(not to mention easier
>>for the customer to program...)
>>
>>
> You are aware that a PPC in little endian mode is merely tricking with the
> low order address bits, but does not actually lay out its data in a little
> endian fashion in physical memory?
>

not according to section 3.1 of the motorola ppc "green book"

according to that it is a sort of munged le representation,

which thanks to a "one trick pony" PCI bridge looks like standard LE to
the PCI based  x86 host.

understand please that what I am proposing is a config option. as a
sub-architecture port.  it would not affect any code that it didn't
absolutely need to, and would only be compiled if sombody selected that
particular config.

I am _NOT_ suggesting running pmacs in LE mode.

as in:
ppc---
      |-- PREP
      |-- CHRP
      |-- MAC
      |-- MERCURY ---
                    |-- Big Endian
                    |-- Little Endian






--
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**         Infinite Justice is niether.           **
**------------------------------------------------*/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
