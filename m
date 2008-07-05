Return-Path: <jengelh@medozas.de>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DC2BDDF0F
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 00:07:48 +1000 (EST)
Date: Sat, 5 Jul 2008 16:07:39 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
Sender: jengelh@sovereign.computergmbh.de
To: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: the printk problem
In-Reply-To: <19f34abd0807050650y327ca434pfca324fcccc14f06@mail.gmail.com>
Message-ID: <alpine.LNX.1.10.0807051606570.28765@fbirervta.pbzchgretzou.qr>
References: <20080705125230.GA20166@damson.getinternet.no>
	<alpine.LNX.1.10.0807051518500.28765@fbirervta.pbzchgretzou.qr>
	<19f34abd0807050650y327ca434pfca324fcccc14f06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
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


On Saturday 2008-07-05 15:50, Vegard Nossum wrote:
>
>I think the most elegant solution would be a macro similar to the
>initcall macros, that adds the custom extensions to a table which is
>defined by a special linker section. This allows complete
>decentralization, but I don't think it's possible to do binary search
>on the names anymore.

With an rbtree, you can still do binary search.
