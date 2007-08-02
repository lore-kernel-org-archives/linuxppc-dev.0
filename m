Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D9FEDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:32:27 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KWO3X010408
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:32:24 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KWNEM255776
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:32:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KWN91005087
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:32:23 -0600
Date: Thu, 2 Aug 2007 15:32:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
Message-ID: <20070802153222.6482ae85@weaponx.rchland.ibm.com>
In-Reply-To: <20070801050542.GJ31391@localhost.localdomain>
References: <20070730151628.GA5100@ru.mvista.com>
	<20070801021541.GE31391@localhost.localdomain>
	<1a27a299b62c4b3a1a1f8fe8912e8e40@kernel.crashing.org>
	<20070801050542.GJ31391@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2007 15:05:42 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 01, 2007 at 07:01:17AM +0200, Segher Boessenkool wrote:
> > >> +	{ /* 440EPX  - without Security/Kasumi  */
> > >> +		.pvr_mask		= 0xf0000fff,
> > >> +		.pvr_value		= 0x200008D4,
> > >> +		.cpu_name		= "440EPX - no Security/Kasumi",
> > >> +		.cpu_features		= CPU_FTRS_44X,
> > >> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 
> > >> 440EPX has an FPU */
> > >> +		.icache_bsize		= 32,
> > >> +		.dcache_bsize		= 32,
> > >> +	},
> > >
> > > Since the with/without Security/Kasumi versions have no differences in
> > > their cputable entry other than the PVR, couldn't you just remove the
> > > relevant PVR bit from the mask and use a single entry?
> > 
> > And get rid of the stupid "has an FPU" comment at the same time
> > please :-)
> 
> Actually that comment may be worthwhile if expanded a little.  I think
> the point is that 440EPx *unlike most other 4xx chips* has an FPU.  So
> the point of the comment is not explaining the feature bit, which is
> obvious, but as a "no, really, it does".

Right.  440EP(x) are the only currently available 44x chips that
contain an FPU, so I also think the comment can stay.

josh
