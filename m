Return-Path: <jengelh@medozas.de>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D56A9DDEEC
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 04:40:13 +1000 (EST)
Date: Sat, 5 Jul 2008 20:40:07 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
Sender: jengelh@sovereign.computergmbh.de
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: the printk problem
In-Reply-To: <alpine.LFD.1.10.0807051045520.2815@woody.linux-foundation.org>
Message-ID: <alpine.LNX.1.10.0807052039520.28765@fbirervta.pbzchgretzou.qr>
References: <20080705125230.GA20166@damson.getinternet.no>
	<alpine.LFD.1.10.0807051045520.2815@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Vegard Nossum <vegard.nossum@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Saturday 2008-07-05 19:56, Linus Torvalds wrote:
>> >
>> > How about %p{feature}?
>
>No.
>
>I _expressly_ chose '%p[alphanumeric]*' because it's basically 
>totally insane to have that in a *real* printk() string: the end result 
>would be totally unreadable.

So, and what do you do when you run out of alphanumeric characters?
