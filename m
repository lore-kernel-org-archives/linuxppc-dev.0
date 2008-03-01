Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5CDD2DDDFC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 10:52:27 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m21NqMmM028908
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 18:52:22 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m21NqMA8222700
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 16:52:22 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m21NqMd7013570
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 16:52:22 -0700
Date: Sat, 1 Mar 2008 17:50:14 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 3/2][NEWEMAC] Use status property for unused/unwired EMACs
Message-ID: <20080301175014.20f0b1e9@zod.rchland.ibm.com>
In-Reply-To: <1204407195.15052.462.camel@pasglop>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301084140.7abc703e@zod.rchland.ibm.com>
	<1204407195.15052.462.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 02 Mar 2008 08:33:15 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Sat, 2008-03-01 at 08:41 -0600, Josh Boyer wrote:
> > Convert ibm_newemac to use the of_device_is_available function when checking
> > for unused/unwired EMACs.  We leave the current check for an "unused" property
> > to maintain backwards compatibility for older device trees.  Newer device
> > trees should simply use the standard "status" property in the EMAC node.
> > 
> > The taishan DTS file is updated to reflect this.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> I don't think any other DTS than Taishan uses "unused" so we may be able
> to get rid of that backward compat check. I think the Cell DT just
> ommits EMACs when they are unused.

I wasn't sure on that aspect and I can't check until next week.  If you
can verify before I do, let me know.  I'll remove the "unused" check
assuming the of_device_is_available patch goes in and the Axon DT
doesn't use it.

josh
