Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id EB134DDDCA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 03:39:17 +1000 (EST)
Date: Sun, 27 Jul 2008 13:39:18 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
Message-ID: <20080727133918.72cbb127@lappy.seanm.ca>
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
"Stephen Rothwell" <sfr@canb.auug.org.au> wrote:

> On powerpc (allyesconfig build) we get this error:
> 
> drivers/isdn/hardware/mISDN/hfcpci.c:1991: error: implicit
> declaration of function 'virt_to_bus'

When did mISDN make it into the kernel? And which kernel tree is it in?
I don't see it in the Linux next tree....

I am very interested since we are trying to get mISDN working on the
Warp. There was no notice that they got 2.6.26 compiling.

Cheers,
   Sean
