Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41D4667BC8
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 16:34:14 +1100 (EST)
Subject: Re: [PATCH 10/15] celleb: SPU support routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612140148.kBE1m8Bp008592@toshiba.co.jp>
References: <200612140148.kBE1m8Bp008592@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 16:34:05 +1100
Message-Id: <1166074445.11914.310.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We think the integration of codes is preferable, but this is our first code
> for public and we need time to modify them. So, this time we hope they are
> merged into as it is. We'd like to discuss and modify our codes toward
> integrated codes after this first merge.  

As much as I would have liked to integrate your code in 2.6.20, it seems
that it won't be possible (as I told you privately earlier today). Linus
is getting fairly strict about the 2 weeks window which closed... today.

We'll merge the code in powerpc.git in the meantime, not in it's current
form but after you have addresses some of the remaning comments. That
way, it will be in -mm at least, and in the powerpc tree which means
that from there, you won't have to rebase it every time we change
something and it will get in first thing in 2.6.21 merge window.

That will also give us more time to address some of the remaining issues
that I'm not too happy with, like some of the PCI bits.

In general, code should be ready to merge -before- the merge window open
or at worst during the first week, the second week being mostly to flush
out bits that collided or needed rebasing etc...

In a similar vein, while some of the PS3 code was actually merged, a lot
of it wasn't yet (drivers etc...) are they are not ready, so it looks
like 2.6.20 won't be the "big cell relase" but 2.6.21 will be instead.

Cheers,
Ben.
