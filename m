Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54F63DDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 10:04:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3Q04aRc001024
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:04:36 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3Q04amJ260098
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:04:36 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3Q04PbN024504
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:04:26 -0400
Date: Fri, 25 Apr 2008 18:58:42 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Increase MDIO timeouts
Message-ID: <20080425185842.7ab463e7@zod.rchland.ibm.com>
In-Reply-To: <1209162158.5420.35.camel@pasglop>
References: <20080423051832.63BF7DDF65@ozlabs.org>
	<20080425165703.864e63bd.billfink@mindspring.com>
	<1209162158.5420.35.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: super.firetwister@googlemail.com, netdev@vger.kernel.org,
	Bill Fink <billfink@mindspring.com>, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 26 Apr 2008 08:22:38 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2008-04-25 at 16:57 -0400, Bill Fink wrote:
> > On Wed, 23 Apr 2008, Benjamin Herrenschmidt wrote:
> > 
> > > This patch doubles the MDIO timeouts in EMAC as there are field
> > > cases where they are two short to communicate with some PHYs.
> > 
> > I guess them being "two short" is why they needed to be doubled.  :-)
> 
> Well, in that case, it makes sense, it's still pretty short and better
> safe than sorry. On day I may look at actually measuring PHYs and see if
> it's worth trying to do sleeping waits in there.

I think you missed Bill's joke.  Read your original email and spot the
typo, then read Bill's pun.

And stop emailing before you eat breakfast ;)

josh
