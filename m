Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7178CDDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 11:37:36 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4V1cspB7131354
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 11:38:54 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4V1f6QM048054
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 11:41:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4V1bX4S030024
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 11:37:34 +1000
Date: Wed, 30 May 2007 21:32:02 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070530113202.GA7714@localhost.localdomain>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
	<a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
	<1180466979.3360.69.camel@zod.rchland.ibm.com>
	<1180523835.19517.245.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180523835.19517.245.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 30, 2007 at 09:17:15PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2007-05-29 at 14:29 -0500, Josh Boyer wrote:
> > 
> > *shrug*  Either way works for me.
> > 
> > We're adding these compatible properties to DTS files and the drivers
> > at
> > the same time.  Unless (until?) there are firmwares for these boards
> > that start specifying something else in a real device tree, it really
> > doesn't matter much.  Not that there's anything wrong with your
> > reasoning.  Just seems like we're trying really hard to define
> > something
> > "correctly" when we control what's on both sides :).
> > 
> 
> I do think Segher is right there... compatible 109 and then 108

That's what I've done in the new patch.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
