Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F8A3DE5AD
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 05:57:47 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m6TJvgB9020349
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 12:57:43 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m6TJvgGU018334
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 14:57:42 -0500 (CDT)
Date: Tue, 29 Jul 2008 14:57:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Sparks, Sam" <SSparks@aclaratech.com>
Subject: Re: mpc8349mITX developement repository
Message-ID: <20080729195741.GA7788@ld0162-tx32.am.freescale.net>
References: <6011A7C9CD0EE74792C3ED2A83556086342170@mail.twacs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6011A7C9CD0EE74792C3ED2A83556086342170@mail.twacs.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 29, 2008 at 02:26:12PM -0500, Sparks, Sam wrote:
> Which repository on kernel.org should I use to pick up the
> latest-greatest software for the mpc8349mITX?
>  
> I've tried linux/kernel/git/vitb/linux-2.6-8xx.git, but the dts doesn't
> contain compact flash nodes.
> I've tried linux/kernel/git/paulus/powerpc.git, but the kernel hangs
> while trying to uncompress.

linux/kernel/git/benh/powerpc.git is the latest.  It boots fine for me.

-Scott
