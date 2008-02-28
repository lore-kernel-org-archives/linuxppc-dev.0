Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B102DDDFEA
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 05:50:09 +1100 (EST)
Date: Thu, 28 Feb 2008 12:50:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] fs_enet: Remove unused fields in the
	fs_mii_bb_platform_info structure.
Message-ID: <20080228185034.GA3897@loki.buserror.net>
References: <200802151427.44321.laurentp@cse-semaphore.com>
	<200802281349.07501.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802281349.07501.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 28, 2008 at 01:49:01PM +0100, Laurent Pinchart wrote:
> On Friday 15 February 2008 14:27, Laurent Pinchart wrote:
> > The mdio_port, mdio_bit, mdc_port and mdc_bit fields in the
> > fs_mii_bb_platform_info structure are left-overs from the move to the Phy
> > Abstraction Layer subsystem. They can be safely removed.
> >
> > Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> [snip]
> 
> Is there something wrong with the patch ?

No, the patch looks OK.  However, note that non-PPC_CPM_NEW_BINDING code
should go away altogether soon.

-Scott
