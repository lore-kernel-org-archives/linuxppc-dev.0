To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] enhanced i2c driver for MPC8xx/MPC8260 CPM ... 
In-reply-to: Your message of "Fri, 31 May 2002 07:47:25 -0700"
             <20020531144725.GG32412@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 01 Jun 2002 12:28:34 +1000
Message-ID: <1109.1022898514@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 31 May 2002 07:47:25 -0700, Tom Rini <trini@kernel.crashing.org> writes:
>> I think the file that includes <linux/i2c-algo-cpm.h> is expected to include
>> commproc.h, or cpm_8260.h, as required. What is the policy on these things?
>> Should every include file include all headers it needs? Anyone?
>
>IMHO, a header file should only include other things which the header
>itself needs.  eg if you do 'u8 foo;' in foo.h, add #include <asm/types.h>

OK, but should it include *all* headers it needs? If so, then the existing
<linux/i2c-algo-8xx.h> should include both <asm/8xx_immap.h> and
<asm/commproc.h> since it uses the types "i2c8xx_t" and "cpm8xx_t".

>Anything the C file needs itself, it should include, and for the sake of
>being explicit (and it's good for multi-arch drivers) if the C code does
>'u8 bar;' it should do #include <asm/types.h> too.

Agreed.

>> Should we take this discussion off the list now? Cheers!
>
>Nah..

I was referring to the discussion about the combined 8xx/8260 i2c driver
I posted. I agree - the above should stay on the list. Cheers!
								Murray...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
