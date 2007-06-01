Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1072DDF42
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 08:42:00 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180716433.14219.11.camel@ld0161-tx32>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
	<A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
	<1180683854.19517.419.camel@localhost.localdomain>
	<46604AE0.5040700@genesi-usa.com>
	<1180716433.14219.11.camel@ld0161-tx32>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 08:41:46 +1000
Message-Id: <1180737707.19517.457.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Wei Zhang <Wei.Zhang@freescale.com>, Paul Mackerras <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 11:47 -0500, Jon Loeliger wrote:
> 
> Therefore, I will go ahead and repost my PCI patch
> series to get PCI-E working again on 8641, and pointed
> in the right direction so we can merge in the support
> for 8548 and 8544 as follow ups.
> 
> We (collectively) will then address the systemic PCI
> problem with 32-bit systems later. 

Exactly.

Cheers,
Ben.
