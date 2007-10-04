Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB93EDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 22:17:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l94CGuF0001575
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 08:16:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l94CGuDN501492
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 06:16:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l94CGuDI020333
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 06:16:56 -0600
Date: Thu, 4 Oct 2007 07:16:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
Message-ID: <20071004071654.611bc5f2@weaponx.rchland.ibm.com>
In-Reply-To: <1191496084.6245.0.camel@pasglop>
References: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
	<1191495405.3647.3.camel@localhost.localdomain>
	<1191496084.6245.0.camel@pasglop>
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

On Thu, 04 Oct 2007 21:08:04 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2007-10-04 at 05:56 -0500, Josh Boyer wrote:
> > On Wed, 2007-10-03 at 22:50 -0600, Grant Likely wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > > 
> > > dcr.c is an arch/powerpc only thing.
> > > 
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > > 
> > > Ben/Paulus,
> > > 
> > > As far as I can tell this is correct.  Having sysdev/dcr.c in the arch/ppc
> > > build spits out warnings.  Grep doesn't show anything in arch/ppc that
> > > is using it.
> > 
> > Sorry, no.  The ibm_emac driver uses it, which is arch/ppc.  (Yes, the
> > old one.)
> > 
> > If there are warnings, let's fix those up.  Perhaps Michael's recent
> > patches in that area introduced something.
> 
> What does it use of dcr.c ? Initially, the 4xx bits where totally
> inline, but maybe Michael's patches is changing that ?

Gah.  Sorry, I was thinking of dcr-low.S, not dcr.c.  And poor Michael
has nothing to do with it.

Drink coffee.  Then think.

josh
