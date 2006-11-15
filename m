Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 602E867C84
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 23:13:09 +1100 (EST)
Date: Wed, 15 Nov 2006 13:12:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 1/16] Cell closs-building
Message-ID: <20061115121256.GB3334@lst.de>
References: <200611150925.kAF9PYiO018978@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611150925.kAF9PYiO018978@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2006 at 06:25:33PM +0900, Ishizaki Kou wrote:
> This patch adds support for cross-building by SCE toolchain.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> ---
> 
> Index: linux-2.6.19/arch/powerpc/Makefile
> diff -u linux-2.6.19/arch/powerpc/Makefile:1.1.1.1 linux-2.6.19/arch/powerpc/Makefile:1.2
> --- linux-2.6.19/arch/powerpc/Makefile:1.1.1.1	Fri Oct  6 10:40:02 2006
> +++ linux-2.6.19/arch/powerpc/Makefile	Fri Oct  6 12:26:35 2006
> @@ -110,6 +110,7 @@
>  CFLAGS		+= -mcpu=powerpc
>  endif
>  
> +cpu-as-$(CONFIG_PPC_CELL)	+= -Wa,-mcellppu

We had this patch a while ago and I was told it's not needed anumore
with a recent gcc.
