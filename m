Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGL4jdRzDr2V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:54 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-8-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [07/21] powerpc: Make functions flipper_pic_init & ug_udbg_putc
 static
Message-Id: <401RGH3PSMz9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:22 UTC, Mathieu Malaterre wrote:
> Change signature of two functions, adding static keyword to prevent the
> following two warnings (treated as errors on W=1):
> 
>   CC      kernel/sys.o
> arch/powerpc/platforms/embedded6xx/flipper-pic.c:135:28: error: no previous prototype for ‘flipper_pic_init’ [-Werror=missing-prototypes]
>  struct irq_domain * __init flipper_pic_init(struct device_node *np)
>                             ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> and
> 
>   CC      arch/powerpc/platforms/embedded6xx/usbgecko_udbg.o
> arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c:172:6: error: no previous prototype for ‘ug_udbg_putc’ [-Werror=missing-prototypes]
>  void ug_udbg_putc(char ch)
>       ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8b51e679a54e808bdf1f2cc6552cf2

cheers
