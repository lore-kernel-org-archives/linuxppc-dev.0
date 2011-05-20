Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B9A1B71A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 05:09:09 +1000 (EST)
Subject: Re: [PATCH 05/14] powerpc/85xx: Updates to P4080DS device tree
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110520140411.75bdea77@schlenkerla.am.freescale.net>
Date: Fri, 20 May 2011 14:09:04 -0500
Message-Id: <3382EE19-633A-4C95-BFC7-530EB3E257B2@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<20110520140411.75bdea77@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 20, 2011, at 2:04 PM, Scott Wood wrote:

> On Fri, 20 May 2011 01:09:22 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
>> * Added BSD dual-license
>> * Moved mpic-parent to root so we dont need to duplicate everywhere
>> * Added next level cache from L2 to CPC
>> * Moved to 4-cell MPIC interrupt properties
>> * Added 3 MSI banks
>> * Added numerous missing nodes: soc-sram-error, guts, pins, clockgen,
>>  rcpm, sfp, serdes, etc.
>> * Reworked PCIe interrupts to be at virtual bridge level
> 
> Have all the new device tree bits (e.g. guts) had bindings posted upstream
> yet?

probably not :(

Will look at our bindings dir and see which ones need upstream pushing.

- k
