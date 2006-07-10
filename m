Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6865B67B5B
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 13:05:58 +1000 (EST)
Subject: Re: patches added to powerpc.git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17582.17835.641485.233064@cargo.ozlabs.ibm.com>
References: <17582.17835.641485.233064@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 13:05:48 +1000
Message-Id: <1152500748.1576.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 21:29 +1000, Paul Mackerras wrote:
> The following patches have been pushed to the powerpc.git tree (master
> branch):
> 
> Benjamin Herrenschmidt:
>       [POWERPC] Workaround Pegasos incorrect ISA "ranges"
>       [POWERPC] Fix 32 bits warning in prom_init.c
>       [POWERPC] Fix non-MPIC CHRPs with CONFIG_SMP set
>       [POWERPC] Fix default clock for udbg_16550
>       [POWERPC] Fix legacy_serial.c error handling on 32 bits
>       [POWERPC] Add briq support to CHRP
>       [POWERPC] Add support for briq front panel
>       [POWERPC] More offb/bootx fixes
>       [POWERPC] Xserve G5 thermal control fixes
>       [POWERPC] Add cpufreq support for Xserve G5

Can you drop the last one please ? (The cpufreq support for Xserve). I
have a bug in there, I'll send a fixed version later today.

Cheers,
Ben.
