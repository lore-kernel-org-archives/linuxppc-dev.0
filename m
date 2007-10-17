Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4ADAEDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 12:00:53 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9H20lM0031508
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 22:00:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9H20bL7373930
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 20:00:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9H20ad3002486
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 20:00:37 -0600
Subject: RE: [PATCH v2] Device tree bindings for Xilinx devices
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20071016232404.5F4D51130091@mail133-blu.bigfish.com>
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
	<20071016232404.5F4D51130091@mail133-blu.bigfish.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 20:49:10 -0500
Message-Id: <1192585750.13993.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au,
	Wolfgang Reissnegger <wre@xilinx.com>, Leonid <Leonid@a-k-a.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-16 at 16:23 -0700, Stephen Neuendorffer wrote:
> It occurs to me that the 'compatible' bindings should probably be the
> name of the preferred driver for the device. 
> 
> > +   l) Xilinx ML300 Framebuffer
> > +    - compatible : Must include "xilinx,ml300-fb"
> Should probably be 'xilinxfb', and probably shouldn't reference ML300 at
> all.
> 
> > +   n) Xilinx EMAC and Xilinx TEMAC
> > +
> > +   Xilinx Ethernet devices.  Uses common properties from 
> > other Ethernet
> > +   devices with the following constraints:
> > +   
> > +   Required properties:
> > +    - compatible : Must include one of: "xilinx,plb-temac",
> > +                   "xilinx,plb-emac", "xilinx-opb-emac"
> Should probably be just 'emac' and 'temac'.

You mean xilinx,emac and xilinx,temac, right?  emac and temac are too
generic by themselves.

josh
