Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ED813DDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 04:16:32 +1100 (EST)
Message-ID: <45A7C265.2080202@am.sony.com>
Date: Fri, 12 Jan 2007 09:16:21 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] PS3: Fix uniprocessor kernel build
References: <Pine.LNX.4.62.0612201611100.11585@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0612201611100.11585@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> Allow to build a uniprocessor kernel for PS3
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/Makefile |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- ps3-linux-src.orig/arch/powerpc/platforms/ps3/Makefile
> +++ ps3-linux-src/arch/powerpc/platforms/ps3/Makefile
> @@ -1,4 +1,5 @@
> -obj-y += setup.o mm.o smp.o time.o hvcall.o htab.o repository.o
> +obj-y += setup.o mm.o time.o hvcall.o htab.o repository.o
>  obj-y += interrupt.o exports.o os-area.o
>  
> +obj-$(CONFIG_SMP) += smp.o
>  obj-$(CONFIG_SPU_BASE) += spu.o

Paul,

If you don't see any trouble, it would be nice for this to go in
for 2.6.20, as it fixes a problem currently in Linus' tree.

Sorry it took so long to merge in and test.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>

-Geoff
