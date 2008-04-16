Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4E5EDE73B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 00:06:13 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GE6Aqv019988
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 10:06:10 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GE68bF1511592
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 10:06:08 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GE5xMW003514
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:05:59 -0600
Date: Wed, 16 Apr 2008 09:02:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080416090235.18c574f6@zod.rchland.ibm.com>
In-Reply-To: <1208354567.6958.289.camel@pasglop>
References: <20080415102704.39511160@zod.rchland.ibm.com>
	<20080416072758.092c83c5@zod.rchland.ibm.com>
	<20080416073139.7f56e72c@zod.rchland.ibm.com>
	<1208350247.6958.283.camel@pasglop>
	<20080416084349.3c9997f1@zod.rchland.ibm.com>
	<1208354567.6958.289.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Apr 2008 00:02:47 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-04-16 at 08:43 -0500, Josh Boyer wrote:
> > 
> > For a final solution, we're going to have to come up with a more
> > clever
> > way of doing the clocking stuff in ibm_newemac.  The SDRs are board
> > specific and completely outside of EMAC/MAL itself.  So doing a
> > dcr_map
> 
> Not board specific... chip specific.

Yes, right.  Sorry.

> > on it becomes a bit more difficult, since there really isn't an SDR
> > node in the device tree at the moment.
> 
> That is why I tried hard to avoid the bloody workarounds...
> unfortunatly, the HW is crap enough that we have no real choice here.

Right.

josh
