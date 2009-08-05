Return-Path: <BATV+428d7bb54dd969b0ba20+2173+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A9CEEB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 07:07:59 +1000 (EST)
Subject: Re: [PATCH] Fix perfctr oops on ppc32
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1249506153.18245.61.camel@pasglop>
References: <1249133370.24204.3.camel@macbook.infradead.org>
	<1249506153.18245.61.camel@pasglop>
Content-Type: text/plain
Date: Wed, 05 Aug 2009 22:07:52 +0100
Message-Id: <1249506472.23206.9.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 07:02 +1000, Benjamin Herrenschmidt wrote:
> 
> Argh, ignore my Acked-by, I think the patch isn't right...

Hm, good point. Doh.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
