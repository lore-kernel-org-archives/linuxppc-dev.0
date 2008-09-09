Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94404DDF40
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 08:10:47 +1000 (EST)
Subject: Re: [PATCH 4/4] POWERPC: Merge 32 and 64-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080909204534.GA30975@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-3-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-4-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<20080908220349.GD1175@lst.de>
	<10D78C52-1FF1-4944-8689-4404ABE98CA1@freescale.com>
	<20080909204534.GA30975@lst.de>
Content-Type: text/plain
Date: Wed, 10 Sep 2008 08:10:31 +1000
Message-Id: <1220998231.14835.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yeah, the statement this time should be why do you keep _single :)
> It don't really mind which one we keep, but having both and both
> optional seems rather odd.

It would be more logic to implement _single on top of _page.. as long as
we can still do sub-page mappings (needed on ppc64) which I think we can
using the offset / size args of _page...

But that means more work changing the existing ppc64 backends :-) So
probably a worthwhile long term goal but what Becky did is ok for the
transition. I can look at fixing up the ppc64 ones to implement page
(and see if that causes any problem) some time after Plumbers conf.

Cheers,
Ben.
 
