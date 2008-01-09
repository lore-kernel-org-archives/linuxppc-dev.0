Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31DF8DE155
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:21:54 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09FLped020807
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 10:21:51 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09FLom5181778
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 08:21:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09FLnmp030343
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 08:21:49 -0700
Date: Wed, 9 Jan 2008 09:21:33 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH] enable built-in networking for Sequoia defconfig
Message-ID: <20080109092133.7ce85e94@zod.rchland.ibm.com>
In-Reply-To: <200801091542.38914.matthias.fuchs@esd-electronics.com>
References: <1199489214.9673.18.camel@basalt>
	<200801091216.25581.matthias.fuchs@esd-electronics.com>
	<20080109060723.06885abd@zod.rchland.ibm.com>
	<200801091542.38914.matthias.fuchs@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2008 15:42:38 +0100
Matthias Fuchs <matthias.fuchs@esd-electronics.com> wrote:

> On Wednesday 09 January 2008 13:07, Josh Boyer wrote:
> > On Wed, 9 Jan 2008 12:16:25 +0100
> > Matthias Fuchs <matthias.fuchs@esd-electronics.com> wrote:
> > 
> > > Josh, 
> > > 
> > > Where did you apply this patch to? Couldn't find it in your for-2.6.25 branch.
> > 
> > I applied it there, just haven't pushed it out yet.  Will do that today.
> > 
> > > BTW, is it normal to edit the defconfig file by hand?
> > 
> > The defconfig?  Not sure.  What I normally do is a make foo_defconfig,
> > edit the .config, make oldconfig, and copy the resulting .config back
> > to foo_defconfig.
> Yes, this is what I also do.
> 
> But how did Hollis get these lines into .config or sequoia_defconfig:
> 
> +CONFIG_IBM_NEW_EMAC=y
> +CONFIG_IBM_NEW_EMAC_RXB=128
> +CONFIG_IBM_NEW_EMAC_TXB=64
> +CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
> +CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
> +CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
> 
> I did not find any Kconfigs where these might come from.

They're in drivers/net/ibm_newemac/Kconfig.

josh
