Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F20B8686A4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 04:19:27 +1100 (EST)
In-Reply-To: <20051107163144.GF3839@smtp.west.cox.net>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107163144.GF3839@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <da56f10d9e365f6194e129205a690c02@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 7 Nov 2005 12:25:12 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 7, 2005, at 11:31 AM, Tom Rini wrote:

> ..... If everything going forward ships from the hw
> vendor with U-Boot,

You can't make that assumption.  Very few production
systems ship with U-Boot, whether we like it or not.
For those of us that developed all of this "boot wrapper"
code and remember why it was done, all of those reasons
still exist.  More people are using U-Boot, but it's mostly
during development.  The other embedded software we
are trying to displace with Linux sometimes doesn't have
the rom space, and there is the "we didn't have it before"
mentality that is hard to change.

Don't cast this old boot code too far away, people still use it.

Thanks.

	-- Dan
