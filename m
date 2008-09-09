Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 396A8DDF76
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 08:13:27 +1000 (EST)
Date: Wed, 10 Sep 2008 00:13:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20080909221321.GA1833@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<20080908220349.GD1175@lst.de>
	<10D78C52-1FF1-4944-8689-4404ABE98CA1@freescale.com>
	<20080909204534.GA30975@lst.de> <1220998231.14835.1.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1220998231.14835.1.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 10, 2008 at 08:10:31AM +1000, Benjamin Herrenschmidt wrote:
> 
> > Yeah, the statement this time should be why do you keep _single :)
> > It don't really mind which one we keep, but having both and both
> > optional seems rather odd.
> 
> It would be more logic to implement _single on top of _page.. as long as
> we can still do sub-page mappings (needed on ppc64) which I think we can
> using the offset / size args of _page...
> 
> But that means more work changing the existing ppc64 backends :-) So
> probably a worthwhile long term goal but what Becky did is ok for the
> transition. I can look at fixing up the ppc64 ones to implement page
> (and see if that causes any problem) some time after Plumbers conf.

Ok.  But it would be good if we could add comments in the code for the
to be done later issues we noted so it's harder to forget it.

> 
> Cheers,
> Ben.
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
---end quoted text---
