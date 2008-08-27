Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30DF8DE429
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 01:41:48 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7RFbM3w001808 for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 08:41:42 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7RF16Xu007073
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 10:01:07 -0500 (CDT)
Date: Wed, 27 Aug 2008 10:01:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chris Skepper <skepper@ukf.net>
Subject: Re: Early boot problem with MPC8247 and Linux 2.6.26
Message-ID: <20080827150105.GB16041@ld0162-tx32.am.freescale.net>
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
> I just left CONFIG_PPC_EARLY_DEBUG_CPM_ADDR at the default value for CPM2? 
> Is that likely to be correct for SMC1?  (I tried looking in the MPC8272 
> reference manual, but couldn't find it.)

The value depends on how the port was set up by firmware (or by the
bootwrapper).  It should be set to wherever the descriptor is, and there
should only be one descriptor that loops back on itself.

-Scott
