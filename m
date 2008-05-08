Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36FFBDDECA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 21:18:29 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m48BIPo0015968
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 07:18:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m48BIPRh263418
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 07:18:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m48BIPPW023480
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 07:18:25 -0400
Date: Thu, 8 May 2008 06:16:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for IBM coreconnect
	busses.
Message-ID: <20080508061649.1f494ada@zod.rchland.ibm.com>
In-Reply-To: <20080508033006.GH5156@yookeroo.seuss>
References: <20080507204734.574B6185804E@mail138-sin.bigfish.com>
	<20080508001850.GB5156@yookeroo.seuss>
	<20080507214630.2f13fd22@zod.rchland.ibm.com>
	<20080508033006.GH5156@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 May 2008 13:30:06 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> On Wed, May 07, 2008 at 09:46:30PM -0500, Josh Boyer wrote:
> > On Thu, 8 May 2008 10:18:50 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > On Wed, May 07, 2008 at 01:47:31PM -0700, Stephen Neuendorffer wrote:
> > > > The IBM coreconnect names are pretty well defined, it appears.  In
> > > > addition, the Xilinx versions of these IPs seem to be proliferating.
> > > > Hence, in the future let's prefer to use the standard names.  I've
> > > > left the old names in for some backward compatibility for existing
> > > > device trees.
> > > > 
> > > > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> > > 
> > > If you're talking about future trees, can't you just slap "simple-bus"
> > > on them avoid this monster id table?
> > 
> > What is that and how does it work?
> 
> ePAPR states that busses which cannot be probed as such (i.e. the
> device tree is the only way to figure out what's on the bus) should
> have "simple-bus" in their compatible property.  You can then just add
> simple-bus to the of_bus_ids list and avoid adding umpteen other things.

Hm.  Hopefully ePAPR will be released soon.

josh
