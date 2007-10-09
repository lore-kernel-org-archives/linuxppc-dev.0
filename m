Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710082100h29c1d2a8hf939ca3306562fac@mail.gmail.com>
Date: Mon, 8 Oct 2007 22:00:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Build failure on treeboot-walnut.c
In-Reply-To: <470AA224.7050709@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/8/07, Timur Tabi <timur@freescale.com> wrote:
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

No; this is something different.  The assember itself is failing
internally.  What version of binutils are you running?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
