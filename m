Date: Fri, 31 May 2002 07:47:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: Rosen Jeremy <Rosen.Jeremy@tms-pty.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] enhanced i2c driver for MPC8xx/MPC8260 CPM ...
Message-ID: <20020531144725.GG32412@opus.bloom.county>
References: <scf74bf6.008@au.thalesgroup.com> <3377.1022808761@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3377.1022808761@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 31, 2002 at 11:32:41AM +1000, Murray Jensen wrote:

> I think the file that includes <linux/i2c-algo-cpm.h> is expected to include
> commproc.h, or cpm_8260.h, as required. What is the policy on these things?
> Should every include file include all headers it needs? Anyone?

IMHO, a header file should only include other things which the header
itself needs.  eg if you do 'u8 foo;' in foo.h, add #include <asm/types.h>

Anything the C file needs itself, it should include, and for the sake of
being explicit (and it's good for multi-arch drivers) if the C code does
'u8 bar;' it should do #include <asm/types.h> too.

> Should we take this discussion off the list now? Cheers!

Nah..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
