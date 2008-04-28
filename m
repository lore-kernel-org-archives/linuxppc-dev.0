Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B870DE3CE
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:33:36 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3SKXMvq003851
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 13:33:23 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SKXMcL014582
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 15:33:22 -0500 (CDT)
Date: Mon, 28 Apr 2008 15:33:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
Message-ID: <20080428203322.GD15223@ld0162-tx32.am.freescale.net>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804251454050.6045@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2008 at 02:57:24PM +0200, Guennadi Liakhovetski wrote:
> is there any specific reason, why out of these 7 patches only the first 
> one made it into the mainline? AFAICS, there has been only one comment, 
> suggesting to replace printk with dev_err on two occasions in one of 
> the patches...

A while ago Paul said on IRC he'd prefer to do the TLF_SLEEPING hack more
like the soft IRQ disabling that 64-bit uses.  I haven't yet had a chance
to look into it, so the patch collects dust, despite the current
implementation of TLF_SLEEPING working just fine.

-Scott
