Message-ID: <3BAA363B.5010400@mc.com>
Date: Thu, 20 Sep 2001 14:32:27 -0400
From: Mark Salisbury <mbs@mc.com>
MIME-Version: 1.0
To: Brad Boyer <flar@pants.nu>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <20010920171002.37DCA2B54A@marcus.pants.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Boyer wrote:

>>>>>question 4. assuming I was willing to deliver a clean, complete LE
>>>>>enabling patch (including devices that are relevant to me), as a compile
>>>>>time config option and maintain that patch, what would be the primary
>>>>>obstacle to inclusion in the main line.
>>>>>
>>>>The objection to being an arch that attempts to support both LE and BE.
>>>>
>>>Note that we already have a precedent: mips and mipsel, both in arch/mips/.
>>>
>>And SH too, iirc.  I know it can be done.  But do we want to do it is the
>>question.
>>
>
> At least in the case of SH, there's a good reason. There's an external pin
> that controls the native endianness of the processor, and most setups just
> have it forcibly pulled high or low. I suspect the MIPS is the same reason,
> since it's used in similar situations. We don't have that excuse with ppc.
> Someone would have to come up with an excuse along the lines of "existing
> hardware won't work unless we do this" like it would have been for SH.
> (I had to work with the SH4e as used by Sega in the Dreamcast...)


well, this is in the context of a multi-CPU type (x86/ppc, sparc/ppc,
ppc/ppc, mips/ppc) shared memory multicomputer.

when dealing w/ direct mapped, shared memory, uniformity of endian-ness
makes many multicomputer problems easier to solve.(not to mention easier
for the customer to program...)




--
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  Thanks to all who sponsored me for the        **
**  Multiple Sclerosis Great Mass Getaway!!       **
**  Robert, Michele and I raised $10,000 and the  **
**  raised over $1,000,000 ride as a whole.  The  **
**  ride was great, and we didn't get rained on!  **
**  Thanks again to all of you who made this      **
**  possible!!                                    **
**------------------------------------------------*/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
