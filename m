Date: Mon, 3 Jun 2002 07:23:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] enhanced i2c driver for MPC8xx/MPC8260 CPM ...
Message-ID: <20020603142333.GD8193@opus.bloom.county>
References: <20020531144725.GG32412@opus.bloom.county> <1109.1022898514@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1109.1022898514@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jun 01, 2002 at 12:28:34PM +1000, Murray Jensen wrote:
>
> On Fri, 31 May 2002 07:47:25 -0700, Tom Rini <trini@kernel.crashing.org> writes:
> >> I think the file that includes <linux/i2c-algo-cpm.h> is expected to include
> >> commproc.h, or cpm_8260.h, as required. What is the policy on these things?
> >> Should every include file include all headers it needs? Anyone?
> >
> >IMHO, a header file should only include other things which the header
> >itself needs.  eg if you do 'u8 foo;' in foo.h, add #include <asm/types.h>
>
> OK, but should it include *all* headers it needs? If so, then the existing
> <linux/i2c-algo-8xx.h> should include both <asm/8xx_immap.h> and
> <asm/commproc.h> since it uses the types "i2c8xx_t" and "cpm8xx_t".

It a header should include all headers that it needs.  If
linux/i2c-algo-8xx.h has 'cpm8xx_t foo;' then it should have been
including <asm/8xx_immap.h> :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
