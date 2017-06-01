Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdpC049SXzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 23:31:08 +1000 (AEST)
In-Reply-To: <20170524080156.1C4936EB78@pc13941vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Linus Walleij <linus.walleij@linaro.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: powerpc: sysdev: simple_gpio: fix Oops in gpio save_regs function
Message-Id: <3wdpC036qdz9sCX@ozlabs.org>
Date: Thu,  1 Jun 2017 23:31:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-24 at 08:01:55 UTC, Christophe Leroy wrote:
> of_mm_gpiochip_add_data() generates an Oops for NULL pointer dereference.
> 
> of_mm_gpiochip_add_data() calls mm_gc->save_regs() before
> setting the data, therefore ->save_regs() cannot use gpiochip_get_data()
> 
> Fixes: 937daafca774b ("powerpc: simple-gpio: use gpiochip data pointer")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6f553912eedafae13ff20b322a65e4

cheers
