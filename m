Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F280CDDF4C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 03:44:48 +1000 (EST)
Date: Sun, 27 Jul 2008 18:27:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
Message-ID: <20080727182709.1dac0556@lxorguk.ukuu.org.uk>
In-Reply-To: <20080728023732.090aff83.sfr@canb.auug.org.au>
References: <20080728023732.090aff83.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Karsten Keil <kkeil@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008 02:37:32 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On powerpc (allyesconfig build) we get this error:
> 
> drivers/isdn/hardware/mISDN/hfcpci.c:1991: error: implicit declaration of function 'virt_to_bus'
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Can we please not merge new virt_to_bus users and instead fix the actual
code to use the right functions?
