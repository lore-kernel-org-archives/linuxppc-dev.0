Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33EA7B6EFE
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:50:58 +1000 (EST)
Subject: Re: [PATCH 04/15] powerpc: Define CPU feature for Architected 2.06
	HV mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <22009.1301985041@neuling.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
	<1301984051-18413-5-git-send-email-benh@kernel.crashing.org>
	<22009.1301985041@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 16:50:48 +1000
Message-ID: <1301986248.2549.141.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-05 at 16:30 +1000, Michael Neuling wrote:
> In message <1301984051-18413-5-git-send-email-benh@kernel.crashing.org> you wrote:
> > This bit indicates that we are operating in hypervisor mode on a CPU
> > compliant to architecture 2.06 or later (currently server only).
> > 
> > We set it on POWER7 and have a boot-time CPU setup function that
> > clears it if MSR:HV isn't set (booting under a hypervisor).
> 
> <snip>
> 
> > +#define CPU_FTR_HVMODE_206		LONG_ASM_CONST(0x0000000800000000)
> 
> FYI With this patch we could remove MMU_FTR_TLBIE_206.

We could... care to send a patch ? :-)

Cheers,
Ben.
