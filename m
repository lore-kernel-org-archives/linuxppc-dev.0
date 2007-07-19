Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 20D39DDEFB
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:45:05 +1000 (EST)
Subject: Re: [PATCH] Treat ISI faults as read faults on classic 32-bit PowerPC
From: Jon Loeliger <jdl@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18078.43412.493174.590540@cargo.ozlabs.ibm.com>
References: <11847726193856-git-send-email-segher@kernel.crashing.org>
	<5d56173bee3f9ea0050aa508e7f27cc932af7229.1184104284.git.segher@kernel.crashing.org>
	<18078.43412.493174.590540@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1184863497.16820.8.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 19 Jul 2007 11:44:57 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-18 at 19:00, Paul Mackerras wrote:

> Hmmm.  The dangling else clauses are pretty gross, and in fact we have
> the same problem on POWER3 and RS64 processors (to be fair, we had
> the problem before and didn't notice, but we should still fix it).
> 
> How about this instead?  Could people test it please?  (Note that
> CPU_FTR_NOEXECUTE is 0 in 32-bit kernels.)
> 
> Paul.
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 0ece513..99c3093 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c

Acked-by: Jon Loeliger <jdl@freescale.com>

Tested on 8641HPCN.

Thanks,
jdl
