Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 275CCDDE2A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 09:30:37 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4RNpCEq340488
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 09:51:12 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4RNY7LF157082
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 09:34:08 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4RNUZhU025139
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 09:30:36 +1000
Date: Mon, 28 May 2007 09:30:31 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070527233031.GB23768@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
	<25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 04:11:59PM +0200, Segher Boessenkool wrote:
> > Waah!  Third time lucky?
> 
> You wish :-)
> 
> > 	- Second, the PHYs give only "bcm54xx" as a compatible
> > property.  This is unfortunate, because there are many bcm54xx PHY
> > models, and they have differences which can matter.  We add a more
> > precise compatible string, giving the precise PHY model (bcm5461A in
> > this case).
> 
> You completely removed the "compatible" properties instead.
> Bad idea.

Um... weren't you the one that was just saying compatible properties
aren't necessary if you can distinguish the hardware in other ways?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
