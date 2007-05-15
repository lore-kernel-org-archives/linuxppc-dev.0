Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3622DDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:03:07 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: Add spinlock to request_phb_iospace()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070515142615.bf748b7a.sfr@canb.auug.org.au>
References: <20070515041655.BDD98DDEC6@ozlabs.org>
	<20070515142615.bf748b7a.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 15 May 2007 16:02:50 +1000
Message-Id: <1179208970.32247.145.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 14:26 +1000, Stephen Rothwell wrote:
> On Tue, 15 May 2007 14:16:26 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > request_phb_iospace() can be called from different CPUs at init
> > time (at least with my next patch) and thus needs a spinlock. As
> > for the next patch, this is a temporary workaround for 2.6.22
> > issues until my rewrite of IO mappings is ready (for 2.6.23)
> 
> What problem is this solving?

See the description of the next patch.

Ben.
