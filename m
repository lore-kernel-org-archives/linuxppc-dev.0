Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86E7ADDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 17:30:20 +1000 (EST)
Subject: Re: Device tree aware EMAC driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070823035601.GL7042@localhost.localdomain>
References: <20070823035601.GL7042@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:30:36 +0200
Message-Id: <1187854236.5972.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-23 at 13:56 +1000, David Gibson wrote:
> 
> 
> Jeff, I've discussed this with BenH, and although there are some
> problems with the driver still, we think it's good enough to merge in
> 2.6.24, the warts can be fixed up later.  Please apply...

Or to be more precise:

This driver will work well for 4xx platforms and will allow us to move a
big step toward getting rid of arch/ppc. The issues with DMA mapping
really only concern the case where this is used within the cell "Axon"
southbridge, which doesn't happen on any released product at this stage.

Ben.
