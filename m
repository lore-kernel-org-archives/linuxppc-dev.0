Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83FFEB71A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 05:06:35 +1000 (EST)
Received: from mail22-tx2 (localhost.localdomain [127.0.0.1])	by
	mail22-tx2-R.bigfish.com (Postfix) with ESMTP id 98FB319706E3	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2011 19:06:30 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.246])	by
	mail22-tx2.bigfish.com (Postfix) with ESMTP id DDEEDB006A	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2011 19:04:14 +0000 (UTC)
Received: from schlenkerla.am.freescale.net (schlenkerla.am.freescale.net
	[10.82.121.12])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id p4KJ4C6A002697	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 14:04:12 -0500 (CDT)
Date: Fri, 20 May 2011 14:04:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/14] powerpc/85xx: Updates to P4080DS device tree
Message-ID: <20110520140411.75bdea77@schlenkerla.am.freescale.net>
In-Reply-To: <1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 May 2011 01:09:22 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> * Added BSD dual-license
> * Moved mpic-parent to root so we dont need to duplicate everywhere
> * Added next level cache from L2 to CPC
> * Moved to 4-cell MPIC interrupt properties
> * Added 3 MSI banks
> * Added numerous missing nodes: soc-sram-error, guts, pins, clockgen,
>   rcpm, sfp, serdes, etc.
> * Reworked PCIe interrupts to be at virtual bridge level

Have all the new device tree bits (e.g. guts) had bindings posted upstream
yet?

-Scott
