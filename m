Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A45BDDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 09:41:03 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8ENexD0014688
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 19:40:59 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8ENexru412230
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 17:40:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8ENexQT009672
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 17:40:59 -0600
Subject: Re: Device tree aware EMAC driver
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1187854236.5972.6.camel@localhost.localdomain>
References: <20070823035601.GL7042@localhost.localdomain>
	<1187854236.5972.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 17:37:47 -0500
Message-Id: <1189809467.24878.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@oss.sgi.com,
	Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-23 at 09:30 +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2007-08-23 at 13:56 +1000, David Gibson wrote:
> > 
> > 
> > Jeff, I've discussed this with BenH, and although there are some
> > problems with the driver still, we think it's good enough to merge in
> > 2.6.24, the warts can be fixed up later.  Please apply...
> 
> Or to be more precise:
> 
> This driver will work well for 4xx platforms and will allow us to move a
> big step toward getting rid of arch/ppc. The issues with DMA mapping
> really only concern the case where this is used within the cell "Axon"
> southbridge, which doesn't happen on any released product at this stage.

Since we have 4 boards that could use this now, and at least one more on
the way, I've put this in the 'emac' branch of my git tree.  That branch
is based off of the current 'upstream' branch of the netdev-2.6 tree.

This is just intended to make it easier for those that want to use
ibm_newemac on their boards while we work the driver into the netdev
tree.

josh
