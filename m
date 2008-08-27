Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5CDBDE2AA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 01:02:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7RF1xVF006999 for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 08:02:01 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7RF1oAc007584
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 10:01:50 -0500 (CDT)
Date: Wed, 27 Aug 2008 10:01:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chris Skepper <skepper@ukf.net>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
Message-ID: <20080827150149.GC16041@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.62.0808221515450.31216@chara.vm.bytemark.co.uk>
	<48AEF220.7080506@freescale.com>
	<Pine.LNX.4.62.0808261219210.3327@chara.vm.bytemark.co.uk>
	<20080826140324.GB3783@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.62.0808261742270.5064@chara.vm.bytemark.co.uk>
	<48B43C42.5040407@freescale.com>
	<Pine.LNX.4.62.0808271413001.14220@chara.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0808271413001.14220@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 27, 2008 at 02:30:47PM +0100, Chris Skepper wrote:
> Is it likely the port isn't set up properly?  udbg_early_init and 
> udbg_init_cpm get called before it probes the machine so there's been no 
> chance to do cpm2_set_pin or anything.

For the early console to work, the pins must have been set up properly by
firmware.

-Scott
