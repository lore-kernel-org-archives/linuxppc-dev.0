Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EF51DDF34
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 02:20:25 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3UGKKE2027617
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 09:20:21 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3UGKJNj018870
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 11:20:20 -0500 (CDT)
Date: Thu, 30 Apr 2009 11:20:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
Subject: Re: FSL Driver load issues with OF
Message-ID: <20090430162019.GA3655@ld0162-tx32.am.freescale.net>
References: <49F821B0.6030706@alcatel-lucent.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F821B0.6030706@alcatel-lucent.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 29, 2009 at 11:45:20AM +0200, Benjamin Zores wrote:
> Since the progressive migration of some PPC drivers to use of_platform bus
> (typically migrating OF parsing from fsl_soc.c to the device probe/init 
> functions),
> I'm experiencing driver load issues.
> 
> Actually, I'm not longer able to load of these drivers as the probe() 
> function is never called.

Make sure your board is calling of_platform_bus_probe(), and that the
devices you're trying to probe are under buses described by the id list.

-Scott
