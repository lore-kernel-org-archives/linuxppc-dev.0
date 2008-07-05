Return-Path: <jengelh@medozas.de>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6573DDF0A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 21:39:14 +1000 (EST)
Date: Sat, 5 Jul 2008 13:33:29 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
Sender: jengelh@sovereign.computergmbh.de
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: the printk problem
In-Reply-To: <20080704150100.1f7b8a65.akpm@linux-foundation.org>
Message-ID: <alpine.LNX.1.10.0807051332200.28765@fbirervta.pbzchgretzou.qr>
References: <20080625131101.GA6205@digi.com> <20080704104634.GA31634@digi.com>
	<20080704111540.ddffd241.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0807041147450.2815@woody.linux-foundation.org>
	<alpine.LFD.1.10.0807041250220.2815@woody.linux-foundation.org>
	<20080704132716.f1e12554.akpm@linux-foundation.org>
	<20080704204252.GM14894@parisc-linux.org>
	<20080704150100.1f7b8a65.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Saturday 2008-07-05 00:01, Andrew Morton wrote:
>
>We don't know how much interest there would be in churning NIPQUAD from
>the net guys.  Interestingly, there's also %C (wint_t) which is a
>32-bit quantity.  So we could just go and say "%C prints an ipv4
>address" and be done with it.  But there's no way of doing that for
>ipv6 addresses so things would become asymmetrical there.

	struct in6_addr src;
	printk("Source address: %p{ipv6}\n", &src);

How about %p{feature}?
