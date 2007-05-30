Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 709ECDDF21
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:36:57 +1000 (EST)
In-Reply-To: <1180466979.3360.69.camel@zod.rchland.ibm.com>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
	<a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
	<1180466979.3360.69.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8b93622a41f822c7b8444d42deb9e5ac@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Wed, 30 May 2007 13:36:49 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <dwg@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We're adding these compatible properties to DTS files and the drivers 
> at
> the same time.  Unless (until?) there are firmwares for these boards
> that start specifying something else in a real device tree, it really
> doesn't matter much.

Sure.  So you have time to work out things now, I
suggest you take advantage of that :-)

> Not that there's anything wrong with your
> reasoning.  Just seems like we're trying really hard to define 
> something
> "correctly" when we control what's on both sides :).

Right now, and in your case, you do.  OTOH, the
goal is to have the DTS be a well-established
stable interface between the firmware/bootloader/
bootwrapper and the kernel; there is no room for
either side of that interface playing dirty tricks,
not on any board ;-)

Also, the DTS files in the kernel source tree should
server as a best-of-breed example for people doing
custom device trees for their own boards.  We better
whip them into good shape or we'll all look foolish...


Segher
