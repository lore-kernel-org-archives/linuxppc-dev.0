Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC6BEDDE03
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 15:06:28 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mA645hTH008140
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 21:05:48 -0700 (MST)
Message-Id: <F282ED4E-DAD7-4091-95A8-3A1AAB331FF8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <1225165821-15998-5-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 4/4] Add SPE/EFP math emulation for E500v1/v2 processors.
Date: Wed, 5 Nov 2008 22:05:42 -0600
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-2-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-3-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-4-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-5-git-send-email-yu.liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 10:50 PM, Liu Yu wrote:

> This patch add the handlers of SPE/EFP exceptions.
> The code is used to emulate float point arithmetic,
> when MSR(SPE) is enabled and receive EFP data interrupt or EFP round  
> interrupt.
>
> This patch has no conflict with or dependence on FP math-emu.
>
> The code has been tested by TestFloat.
>
> Now the code doesn't support SPE/EFP instructions emulation
> (it won't be called when receive program interrupt),
> but it could be easily added.
>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> arch/powerpc/include/asm/processor.h   |    6 +
> arch/powerpc/include/asm/sfp-machine.h |   36 ++-
> arch/powerpc/kernel/head_fsl_booke.S   |    7 +-
> arch/powerpc/kernel/traps.c            |   62 +++-
> arch/powerpc/math-emu/Makefile         |    2 +
> arch/powerpc/math-emu/math_efp.c       |  720 +++++++++++++++++++++++ 
> +++++++++
> 6 files changed, 813 insertions(+), 20 deletions(-)
> create mode 100644 arch/powerpc/math-emu/math_efp.c


applied to next.

- k
