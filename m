Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by ozlabs.org (Postfix) with ESMTP id AA68AB7CF3
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Feb 2010 06:36:27 +1100 (EST)
Date: Thu, 18 Feb 2010 23:57:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: register long sp asm("r1") incorrect
Message-ID: <20100218225711.GA1386@ucw.cz>
References: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>
	<1265866273.16346.34.camel@pasglop>
	<20100215073405.GB20456@atrey.karlin.mff.cuni.cz>
	<1266263992.16346.125.camel@pasglop>
	<20100215202854.GA21601@elf.ucw.cz>
	<1266267898.16346.135.camel@pasglop> <4B79C775.1050903@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B79C775.1050903@zytor.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 2010-02-15 14:15:17, H. Peter Anvin wrote:
> On 02/15/2010 01:04 PM, Benjamin Herrenschmidt wrote:
> > 
> > It's true that most other use of it we have are global scope (local_paca
> > in r13, glibc use of r2/r13, etc...) afaik, but since r1 itself is the
> > stack pointer always, I think they pretty much guarantee it works.
> > 
> 
> It should work, because r1, being the stack pointer, is already marked a
> reserved register in gcc.
> 
> The reference Pavel is citing bascially states that gcc won't globally
> reserve the register, which is true, but it is already reserved anyway.

Ok, thanks for clarification.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
