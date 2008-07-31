Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E481CDE287
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 06:37:47 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m6VKbeP2028645
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:37:40 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6VKbeUG000227
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 15:37:40 -0500 (CDT)
Date: Thu, 31 Jul 2008 15:37:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: libata badness
Message-ID: <20080731203739.GA17718@ld0162-tx32.am.freescale.net>
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org>
	<20080731190259.GJ26938@trinity.fluff.org>
	<836C281D-4D3A-4547-98D9-143A690698AF@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <836C281D-4D3A-4547-98D9-143A690698AF@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Ben Dooks <ben-linux@fluff.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 03:24:31PM -0500, Kumar Gala wrote:
> >it would be helpful to compile a kernel with verbose fault information
> >turned on.
> 
> Doesn't seem to provide too much more info on ppc.

I'm pretty sure it does the same thing on ppc as on all the other
architectures.

> just says the file/ line number of the badness.

...which is a lot more useful than an address in someone else's kernel
image.

-Scott
