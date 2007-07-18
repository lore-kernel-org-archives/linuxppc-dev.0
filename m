Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F97EDDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 15:04:51 +1000 (EST)
In-Reply-To: <20070718013302.GE15238@ld0162-tx32.am.freescale.net>
References: <20070718013302.GE15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F44085F-8A67-4134-95A3-39897F2A84FD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/61] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Date: Wed, 18 Jul 2007 00:05:13 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 8:33 PM, Scott Wood wrote:

> On arch/ppc, Soft_emulate_8xx was used when full math emulation was
> turned off to emulate a minimal subset of floating point load/store
> instructions, to avoid needing a soft-float toolchain.  This function
> is called, but not present, on arch/powerpc, causing a build error
> if floating point emulation is turned off.
>
> As soft-float toolchains are now common, I'm deleting the call rather
> than moving Soft_emulate_8xx over to arch/powerpc.

We should move the Soft_emulate_8xx code over.  I see no reason to  
break a usage model that existed in arch/ppc.

- k
