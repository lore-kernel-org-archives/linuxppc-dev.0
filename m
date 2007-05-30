Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C502DE042
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:50:38 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4UDoaeA006085
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 09:50:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4UDoYba219964
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:50:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4UDoXXu012631
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:50:33 -0600
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <8b93622a41f822c7b8444d42deb9e5ac@kernel.crashing.org>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
	<a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
	<1180466979.3360.69.camel@zod.rchland.ibm.com>
	<8b93622a41f822c7b8444d42deb9e5ac@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 08:48:19 -0500
Message-Id: <1180532899.3360.79.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
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

On Wed, 2007-05-30 at 13:36 +0200, Segher Boessenkool wrote:
> > We're adding these compatible properties to DTS files and the drivers 
> > at
> > the same time.  Unless (until?) there are firmwares for these boards
> > that start specifying something else in a real device tree, it really
> > doesn't matter much.
> 
> Sure.  So you have time to work out things now, I
> suggest you take advantage of that :-)
> 
> > Not that there's anything wrong with your
> > reasoning.  Just seems like we're trying really hard to define 
> > something
> > "correctly" when we control what's on both sides :).
> 
> Right now, and in your case, you do.  OTOH, the
> goal is to have the DTS be a well-established
> stable interface between the firmware/bootloader/
> bootwrapper and the kernel; there is no room for
> either side of that interface playing dirty tricks,
> not on any board ;-)
> 
> Also, the DTS files in the kernel source tree should
> server as a best-of-breed example for people doing
> custom device trees for their own boards.  We better
> whip them into good shape or we'll all look foolish...

Yeah, I know.  Ignore my earlier email.  I blame it on lack of sleep.

The only issue we might have in the future is if DT capable firmware for
these boards shows up and does something completely different.
Hopefully that won't happen.

josh
