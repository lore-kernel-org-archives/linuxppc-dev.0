Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 491E5DE2DD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 04:13:21 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3SIDF3a028397
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 11:13:15 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SIDEEB028967
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 13:13:14 -0500 (CDT)
Date: Mon, 28 Apr 2008 13:13:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <LeoLi@freescale.com>
Subject: Re: [PATCH] MTD: fix partition scan control logic in physmap_ofand
	fsl_elbc_nand
Message-ID: <20080428181314.GK9849@ld0162-tx32.am.freescale.net>
References: <1204201051-13107-1-git-send-email-leoli@freescale.com>
	<1208890162.9212.646.camel@pmac.infradead.org>
	<989B956029373F45A0B8AF029708189002007C8F@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <989B956029373F45A0B8AF029708189002007C8F@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2008 at 07:09:59PM +0800, Li Yang wrote:
> The error can also be soft error like a typo in the cmdline or device
> tree.  I could be better to try other ways to see if we can find a sane
> partition table than just to fail.

If cmdline partition information exists, typo or not, then obviously
there was intent for the cmdline to be used.  It's better to let the user
know there's a problem than silently fall back to some other, likely
wrong partition information.

-Scott
