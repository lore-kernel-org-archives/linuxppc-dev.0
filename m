Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F47CDDEF2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:49:17 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4T58exD263990
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 15:08:46 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4T4pRLx170268
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:51:30 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4T4lqZk001057
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 14:47:52 +1000
Date: Tue, 29 May 2007 14:47:50 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Message-ID: <20070529044750.GC30266@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
	<25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
	<20070527233031.GB23768@localhost.localdomain>
	<3b1087a7734a3836346e181eef4b606a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3b1087a7734a3836346e181eef4b606a@kernel.crashing.org>
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

On Mon, May 28, 2007 at 01:06:11PM +0200, Segher Boessenkool wrote:
> >>> 	- Second, the PHYs give only "bcm54xx" as a compatible
> >>> property.  This is unfortunate, because there are many bcm54xx PHY
> >>> models, and they have differences which can matter.  We add a more
> >>> precise compatible string, giving the precise PHY model (bcm5461A in
> >>> this case).
> >>
> >> You completely removed the "compatible" properties instead.
> >> Bad idea.
> >
> > Um... weren't you the one that was just saying compatible properties
> > aren't necessary if you can distinguish the hardware in other ways?
> 
> The OS device driver doesn't need "compatible" if it
> can probe the device some other way; it doesn't need
> the device node at all, even.  You still should have
> a "compatible" property (or, old style, a specific
> "name" property) if you want the OS to be able to use
> the device node to recognise the device (i.e., if a
> device node for the device exists at all: always).

Hrm.  Ok.  compatible property restored.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
