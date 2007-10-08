Return-Path: <timur@freescale.com>
Message-ID: <470AA224.7050709@freescale.com>
Date: Mon, 08 Oct 2007 16:33:24 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Build failure on treeboot-walnut.c
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
In-Reply-To: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks like the problem is back:

   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
Assembler messages:
Error: Internal assembler error for instruction icbt
Internal error, aborting at 
/tmp/crosstool/crosstool-0.42/build/powerpc-unknown-linux-gnu/gcc-4.0.2_e300-enabled-glibc-2.3.6/binutils-2.16.1-complete/gas/config/tc-ppc.c 
line 1314 in ppc_setup_opcodes
Please report this bug.
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
make: *** [uImage] Error 2

Question: I'm building a kernel for the 8610.  Why is treeboot-walnut.c being 
compiled at all?

Grant Likely wrote:
> Building Paul's current powerpc branch with a ppc6xx compiler causes
> the following build failure:
> 
>   SYSMAP  System.map
>   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> {standard input}: Assembler messages:
> {standard input}:184: Error: Unrecognized opcode: `mfdcr'
> {standard input}:185: Error: Unrecognized opcode: `mfdcr'
> {standard input}:186: Error: Unrecognized opcode: `mfdcr'
> {standard input}:217: Error: Unrecognized opcode: `mtdcr'
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 1
> make: *** [uImage] Error 2
> 
> This is using ELDK 4.1:
> GNU assembler version 2.16.1 (powerpc-linux) using BFD version 2.16.1
> gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)
> 
> Cheers,
> g.
> 


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
