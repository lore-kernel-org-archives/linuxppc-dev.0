Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E662DDDF02
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 04:44:12 +1000 (EST)
Date: Sat, 5 Jul 2008 11:44:03 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: the printk problem
In-Reply-To: <alpine.LNX.1.10.0807052039520.28765@fbirervta.pbzchgretzou.qr>
Message-ID: <alpine.LFD.1.10.0807051142050.2815@woody.linux-foundation.org>
References: <20080705125230.GA20166@damson.getinternet.no>
	<alpine.LFD.1.10.0807051045520.2815@woody.linux-foundation.org>
	<alpine.LNX.1.10.0807052039520.28765@fbirervta.pbzchgretzou.qr>
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



On Sat, 5 Jul 2008, Jan Engelhardt wrote:
> 
> So, and what do you do when you run out of alphanumeric characters?

Did you actually look at my patch?

It's not a single alnum character. It's an arbitrary sequence of alnum 
characters. IOW, my patch allows

	%p6N

or something like that for showing a ipv6 "NIP" format string etc. Or you 
could spell them out even more, although I consider it unlikely that you 
really want to see too many of these, since gcc won't actually be able to 
type-check them (so they will always remain _secondary_ formats).

			Linus
