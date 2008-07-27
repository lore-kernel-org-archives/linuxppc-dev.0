Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7351BDDF87
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 05:56:05 +1000 (EST)
Date: Sun, 27 Jul 2008 12:56:04 -0700 (PDT)
Message-Id: <20080727.125604.73857337.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080727182709.1dac0556@lxorguk.ukuu.org.uk>
References: <20080728023732.090aff83.sfr@canb.auug.org.au>
	<20080727182709.1dac0556@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 27 Jul 2008 18:27:09 +0100

> On Mon, 28 Jul 2008 02:37:32 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > On powerpc (allyesconfig build) we get this error:
> > 
> > drivers/isdn/hardware/mISDN/hfcpci.c:1991: error: implicit declaration of function 'virt_to_bus'
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Can we please not merge new virt_to_bus users and instead fix the actual
> code to use the right functions?

Yes, please.

IMHO, this driver was really rushed in and that was a huge mistake.
If it had gone through linux-next we could have tidied all of this
stuff up in a less "rushed" manner.
