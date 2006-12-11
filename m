Return-Path: <SRS0+61c1008cfb9f6953af6c+1205+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0E5F67D79
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 09:14:50 +1100 (EST)
Date: Mon, 11 Dec 2006 22:14:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
Message-ID: <20061211221445.GA17999@infradead.org>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
	<20061211112017.GA16399@infradead.org>
	<1165868903.7260.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165868903.7260.53.camel@localhost.localdomain>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2006 at 07:28:23AM +1100, Benjamin Herrenschmidt wrote:
> > Same here, btw - except that I couldn't catch the exact message as
> > nicely.
> 
> Yeah, fixed in the patch I sent yesterday [PATCH] powerpc: Fix irq
> routing on some PowerMac 32 bit.

Confirmed, everything is fine with that patch.
