Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [64.81.246.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2279D68AD0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 11:59:17 +1100 (EST)
Date: Wed, 25 Jan 2006 16:06:18 -0800
From: Richard Henderson <rth@twiddle.net>
To: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
	dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
	ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060126000618.GA5592@twiddle.net>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060125200250.GA26443@flint.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 08:02:50PM +0000, Russell King wrote:
> > +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> > +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> > +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
...
> Basically, shifts which depend on a variable are more expensive than
> constant-based shifts.

Actually, they're all constant shifts.  Just written stupidly.


r~
