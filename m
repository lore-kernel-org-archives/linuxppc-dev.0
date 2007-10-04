Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBED5DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 21:08:11 +1000 (EST)
Subject: Re: [PATCH] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1191495405.3647.3.camel@localhost.localdomain>
References: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
	<1191495405.3647.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 21:08:04 +1000
Message-Id: <1191496084.6245.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-04 at 05:56 -0500, Josh Boyer wrote:
> On Wed, 2007-10-03 at 22:50 -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> > 
> > dcr.c is an arch/powerpc only thing.
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> > Ben/Paulus,
> > 
> > As far as I can tell this is correct.  Having sysdev/dcr.c in the arch/ppc
> > build spits out warnings.  Grep doesn't show anything in arch/ppc that
> > is using it.
> 
> Sorry, no.  The ibm_emac driver uses it, which is arch/ppc.  (Yes, the
> old one.)
> 
> If there are warnings, let's fix those up.  Perhaps Michael's recent
> patches in that area introduced something.

What does it use of dcr.c ? Initially, the 4xx bits where totally
inline, but maybe Michael's patches is changing that ?

Ben.
