Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92DFFDDFBC
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 08:11:22 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4LMBGmb003673
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 15:11:17 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m4LMBGrA007076
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 17:11:16 -0500 (CDT)
Date: Wed, 21 May 2008 17:11:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] mpic: deal with bogus NIRQ in Feature Reporting
	Register
Message-ID: <20080521221115.GB5156@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0805211557380.31707@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0805211557380.31707@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 03:57:55PM -0500, Kumar Gala wrote:
> Some chips (like the SoCs from Freescale) report the wrong value in NIRQ
> and this causes issues if its doesn't match or exceed the value of
> irq_count.

Is it really wrong, or just not accounting for the gap between external
and internal interrupts?

-Scott
