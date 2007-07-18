Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2198CDDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 06:11:22 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6IK5Z4G025592
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 16:05:36 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6IKBIgN262794
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:11:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6IKBEmU027911
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:11:14 -0600
Subject: Re: [patch 14/14] Bamboo zImage wrapper
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <1184781073.16299.29.camel@weaponx.rchland.ibm.com>
References: <6e26faa3f30dddc5fcf6294a1ecb3a78@bga.com>
	<1184781073.16299.29.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 15:11:13 -0500
Message-Id: <1184789473.16299.52.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-18 at 12:51 -0500, Josh Boyer wrote:
> > Is there some reason they should not all be merged into this one 
> > platform file?
> 
> "they" meaning what?
> 
> > I can understand wanting the dcr fixups as a library, but lets wait to 
> > do the file splits until there are actually users.  Its also easier to 
> > see what's going to called when all the platform ops are filled in at 
> > one spot, not spread over multiple files.
> 
> I copied this from Ebony.  There are multiple users already.  You have
> two parts.  The truly common stuff in 4xx.c and the board specific
> wrappers that do the things needed for the board.
> 
> You've thoroughly confused me.

Some discussion on IRC cleared this up.  Milton was suggesting I merge
the treeboot-bamboo.c and bamboo.c files together.  I'm avoiding that
because I do plan on creating a cuboot Bamboo target soon.

There is a method to my madness usually.

josh
