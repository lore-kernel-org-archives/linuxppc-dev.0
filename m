Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C26EFDDF9F
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 04:55:02 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0FHsvtX014379
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 10:54:58 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0FHsvSj017690
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 11:54:57 -0600 (CST)
Date: Thu, 15 Jan 2009 11:54:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>,
	-@ld0162-tx32.am.freescale.net
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Message-ID: <20090115175456.GA11405@ld0162-tx32.am.freescale.net>
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<200901151418.28882.laurentp@cse-semaphore.com>
	<98B0EC36-C1AE-44F0-98CC-F1AED0B9E299@kernel.crashing.org>
	<200901151558.50816.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901151558.50816.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 03:58:50PM +0100, Laurent Pinchart wrote:
> On Thursday 15 January 2009 15:42:14 Kumar Gala wrote:
> > On Jan 15, 2009, at 7:18 AM, Laurent Pinchart wrote:
> > >
> > > 2.6.29-rc1 is out and I haven't seen the patch being applied
> > > anywhere. Is there any blocking issue ?
> >
> > I wasn't sure if you and Scott had come to resolution on the rounding
> > issue.
> 
> I think we have. Scott, can you confirm ?

I think the patch is correct, and I need to look into why it gives me
problems on mpc8272ads (while solving similar issues on some other
boards).

-Scott
