Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 6AE2D2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 03:03:50 +1100 (EST)
Date: Thu, 18 Nov 2004 09:03:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: alebas@televes.com
Message-ID: <20041118160339.GB12054@smtp.west.cox.net>
References: <1100264953.4194b5f9eab0f@webmail.televes.com:443>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100264953.4194b5f9eab0f@webmail.televes.com:443>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [patch] Solves syslib/m8260_setup.c ROOT_DEV problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 12, 2004 at 02:09:13PM +0100, alebas@televes.com wrote:

> Hi,
> 
> This patch applies against head versions of both linuxppc-2.5 in ppc.bkbits.net
> and linux-2.5 in linux.bkbits.net
> 
> I don't now if this has been corrected in some other tree.
> 
> The patch corrects the following error during compilation
> 
>   LD      arch/ppc/lib/built-in.o
>   CC      arch/ppc/syslib/m8260_setup.o
> arch/ppc/syslib/m8260_setup.c: In function `m8260_setup_arch':
> arch/ppc/syslib/m8260_setup.c:56: `ROOT_DEV' undeclared (first use in this
> function)
> arch/ppc/syslib/m8260_setup.c:56: (Each undeclared identifier is reported only
> once
> arch/ppc/syslib/m8260_setup.c:56: for each function it appears in.)
> arch/ppc/syslib/m8260_setup.c:56: `Root_RAM0' undeclared (first use in this
> function)
> arch/ppc/syslib/m8260_setup.c: In function `m8260_show_cpuinfo':
> arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
> int arg (arg 5)
> arch/ppc/syslib/m8260_setup.c:149: warning: int format, long unsigned int arg
> (arg 6)
> arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
> int arg (arg 7)
> arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
> int arg (arg 8)
> arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
> int arg (arg 9)
> make[1]: *** [arch/ppc/syslib/m8260_setup.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
> 
> Here, arch was ppc and configuration was ads8272_defconfig.

I'll push something similar, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
