Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id A9E492BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 00:56:57 +1100 (EST)
Date: Wed, 3 Nov 2004 06:56:45 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Vladimir <vova-ks@yandex.ru>
Message-ID: <20041103065645.A3357@home.com>
References: <200411031241.40681.vova-ks@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411031241.40681.vova-ks@yandex.ru>;
	from vova-ks@yandex.ru on Wed, Nov 03, 2004 at 12:41:40PM +0300
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kgdb on 405GP walnut-like board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 03, 2004 at 12:41:40PM +0300, Vladimir wrote:
> Hello All !
> When I'm trying to compile linux-2.6.8.1 kernel on ppc with kgdb support it 
> fails with the following error:
> 
> arch/ppc/kernel/ppc-stub.c:796: structure has no member named `dbcr0'
> 
> Can I just replace regs->dbcr0 with current->thread.dbcr0. Is it sufficient ?
> Has this issue already been fixed by someone ?

No, it's not sufficient.  It helps to check the archives first.

http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/000417.html
http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/000418.html

These are now in the 2.6 mainline (BK current).

-Matt
