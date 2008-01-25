Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35111DDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:53:31 +1100 (EST)
Date: Fri, 25 Jan 2008 02:50:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv3 0/7] [POWERPC] 8xx cleanups
In-Reply-To: <4798AB95.8040405@scram.de>
Message-ID: <Pine.LNX.4.64.0801250249170.11624@blarg.am.freescale.net>
References: <4798AB95.8040405@scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Jochen Friedrich wrote:

> Hi,
>
> this is a series against paulus for-2.6.25 tree to clean up various 8xx
> related stuff.
> The series can be pulled from git://git.bocc.de/dbox2.git cleanup.
> Old patches 2+4 have been merged into Patch 2. Patch 4 has been modified to
> move the
> prototypes into a new platforms/8xx/mpc8xx.h. Patch 5 leaves the PCMCIA bits
> in
> asm-powerpc/mpc8xx.h as this driver needs to be fixed first (unfortunately, i
> don't
> have an 8xx board with PCMCIA). I would suggest removing asm-powerpc/mpc8xx.h
> after
> ARCH=ppc is gone to avoid adding #ifdefs to all shared drivers.
>
> I also modified an option in Thunderbird so i hope whitespaces are OK now :-/
>
> [POWERPC] Remove unused m8xx_cpm_hostalloc/free/dump()
> [POWERPC] Rename m8xx_pic_init to mpc8xx_pics_init
> [POWERPC] Remove unneeded and misspelled prototype m8xx_calibrate_decr
> [POWERPC] Remove sysdev/commproc.h
> [POWERPC] Get rid of conditional includes of board specific setup

I've applied the above patches.

> [POWERPC] Rename commproc to cpm1 and cpm2_common.c to cpm2.c

I'm a bit concerned this patch is touching too many files.. or ones that
it never should have.

> [POWERPC] Move definition of buffer descriptor to cpm.h

I'm assmuing this patch depends on the previous one.

- k
