Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19E0BDDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:54:55 +1000 (EST)
Subject: Re: [PATCH 1/5] Update ibm_newemac to use dcr_host_t.base
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4713B2A1.4000503@pobox.com>
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
	<4713B2A1.4000503@pobox.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 06:54:42 +1000
Message-Id: <1192481682.11795.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-15 at 14:34 -0400, Jeff Garzik wrote:
> Michael Ellerman wrote:
> > Now that dcr_host_t contains the base address, we can use that in the
> > ibm_newemac code, rather than storing it separately.
> > 
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >  drivers/net/ibm_newemac/mal.c |    9 +++++----
> >  drivers/net/ibm_newemac/mal.h |    5 ++---
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> applied 1-5

Those patches have been around for some time now, they didn't make
paulus initial merge for reasons I'm not sure about but I think they
should go into 2.6.24. Now the question is via Jeff or via Paulus ? :-)
 
Ben.
