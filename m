Return-Path: <sam@ravnborg.org>
Received: from smtpout3.tre.se (smtpout3.tre.se [80.251.192.228])
	by ozlabs.org (Postfix) with ESMTP id 8E480DDF67
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 06:44:12 +1000 (EST)
Date: Sun, 27 Jul 2008 22:43:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
Message-ID: <20080727204355.GA14057@uranus.ravnborg.org>
References: <20080728023732.090aff83.sfr@canb.auug.org.au>
	<20080727182709.1dac0556@lxorguk.ukuu.org.uk>
	<20080727.125604.73857337.davem@davemloft.net>
	<adamyk35aoi.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adamyk35aoi.fsf@cisco.com>
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 27, 2008 at 01:33:49PM -0700, Roland Dreier wrote:
>  > IMHO, this driver was really rushed in and that was a huge mistake.
>  > If it had gone through linux-next we could have tidied all of this
>  > stuff up in a less "rushed" manner.
> 
> ??  This thread *is* about a build failure in linux-next.
mISDN are in -linus which is part of -next and Stephens point is that if
we have had mISDN in -next then this would have been fixed before hitting
-linus. Maybe Karsten should use davem as gateway as he has anyway been
so for other isdn patches lately?

	Sam
