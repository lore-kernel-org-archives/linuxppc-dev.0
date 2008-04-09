Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BCF5DE135
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 02:11:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m39GBAEP012028
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 09:11:11 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m39GBARt005106
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 11:11:10 -0500 (CDT)
Date: Wed, 9 Apr 2008 11:11:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] FCC: fix confused base / offset
Message-ID: <20080409161110.GA5296@ld0162-tx32.am.freescale.net>
References: <20080409130610.GE10465@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080409130610.GE10465@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2008 at 03:06:10PM +0200, Sascha Hauer wrote:
> This patch fixes a mixup in struct fs_platform_info. The struct has a field
> dpram_offset which really is no offset but an io pointer to the dpram
> (casted to u32).

Right, I didn't want to touch that as the old-binding code should be
going away soon anyway.  Does this break arch/ppc, BTW?

-Scott
