Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F33CDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 02:26:56 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n45GQo1V005785
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 09:26:50 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n45GQoPt000960
	for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2009 11:26:50 -0500 (CDT)
Date: Tue, 5 May 2009 11:26:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Sauce.Cheng" <chmhou@sina.com>
Subject: Re: PPC8247 booting error
Message-ID: <20090505162649.GA4473@ld0162-tx32.am.freescale.net>
References: <23381214.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23381214.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 04, 2009 at 10:23:50PM -0700, Sauce.Cheng wrote:
> i want to mapping FIFO memory to bank 3 by configure br3 and or3
> the boot info as following.
> 
> in my code, i have mapped FIFO to 0xD0000000, then i red the value from this
> address.
> 
> the prompts as following 
> 
> there is some wrong with BRx and ORx set? or something others?

You need to pass your physical address (0xd0000000) to ioremap() to
obtain a virtual address that you can dereference.

> scheduling while atomic: swapper/0x00000002/0
> 
> Call trace: [c015fe20]  [c0003fe0]  [c01a09b4]  [c0194614]  [000035fc] 

You've got another problem here that you'll want to look into.

-Scott
