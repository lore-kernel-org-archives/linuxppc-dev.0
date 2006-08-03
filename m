Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Message-ID: <17617.30304.366738.986854@cargo.ozlabs.ibm.com>
Date: Thu, 3 Aug 2006 14:06:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] clean up pseries hcall interfaces
In-Reply-To: <44C68544.9000609@am.sony.com>
References: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>
	<20060725144124.GA3769@krispykreme> <44C68544.9000609@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> Change the scope of some pSeries routines now called through
> ppc_md to static.

With this I get:

  CC      arch/powerpc/platforms/pseries/lpar.o
/home/paulus/kernel/powerpc/arch/powerpc/platforms/pseries/lpar.c:273: error: static declaration of ‘pSeries_lpar_hpte_insert’ follows non-static declaration
include2/asm/mmu.h:254: error: previous declaration of ‘pSeries_lpar_hpte_insert’ was here
make[3]: *** [arch/powerpc/platforms/pseries/lpar.o] Error 1
make[2]: *** [arch/powerpc/platforms/pseries] Error 2
make[1]: *** [arch/powerpc/platforms] Error 2
make: *** [_all] Error 2

Paul.
