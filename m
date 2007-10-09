Return-Path: <dgibson@ozlabs.org>
Date: Tue, 9 Oct 2007 13:07:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Build failure on treeboot-walnut.cg
Message-ID: <20071009030729.GI12499@localhost.localdomain>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <470AA224.7050709@freescale.com>
Cc: linuxppc-dev@ozlabs.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 08, 2007 at 04:33:24PM -0500, Timur Tabi wrote:
> Looks like the problem is back:
> 
>    BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> Assembler messages:
> Error: Internal assembler error for instruction icbt
> Internal error, aborting at 
> /tmp/crosstool/crosstool-0.42/build/powerpc-unknown-linux-gnu/gcc-4.0.2_e300-enabled-glibc-2.3.6/binutils-2.16.1-complete/gas/config/tc-ppc.c 
> line 1314 in ppc_setup_opcodes
> Please report this bug.
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
> make: *** [uImage] Error 2

I thought that got fixed already, did the CFLAGS override fall out
somehow?

> Question: I'm building a kernel for the 8610.  Why is treeboot-walnut.c being 
> compiled at all?

Policy.  Compiling everything means build bugs - like this one - can
be found by everybody, not just those building for the specific
obscure platform.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
