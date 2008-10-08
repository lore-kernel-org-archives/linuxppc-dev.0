Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0877DE1B4
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 08:02:55 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m98L1TVw020750
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Oct 2008 14:02:50 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m98KkcwO014727
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Oct 2008 15:46:38 -0500 (CDT)
Date: Wed, 8 Oct 2008 15:46:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
Message-ID: <20081008204638.GA5422@ld0162-tx32.am.freescale.net>
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223496186.8157.82.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 07:03:06AM +1100, Benjamin Herrenschmidt wrote:
> No. Instead, send a patch that fixes the defconfig's to explicitely set
> those to "n". 

What's the difference, other than wasting some bytes in the Kconfig file?

> As to whether those should be defaults or not, this is a different
> discussion (I'm almost tempted to have everything default to y).

Please, no.  It's much easier to turn on what you want, than to go
through menuconfig turning a million things off.

-Scott
