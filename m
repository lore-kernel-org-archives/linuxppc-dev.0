Return-Path: <linus.walleij@linaro.org>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbs9C5mxYzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 19:37:51 +1000 (AEST)
Received: by mail-it0-x233.google.com with SMTP id g126so24218460ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 02:37:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170524080156.1C4936EB78@pc13941vm.idsi0.si.c-s.fr>
References: <20170524080156.1C4936EB78@pc13941vm.idsi0.si.c-s.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 May 2017 11:37:48 +0200
Message-ID: <CACRpkdY4Y=Z7BVpeUxhYNdj815HQORo+TzfhbQATtbRMsurQLA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: sysdev: simple_gpio: fix Oops in gpio save_regs
 function
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 24, 2017 at 10:01 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> of_mm_gpiochip_add_data() generates an Oops for NULL pointer dereference.
>
> of_mm_gpiochip_add_data() calls mm_gc->save_regs() before
> setting the data, therefore ->save_regs() cannot use gpiochip_get_data()
>
> Fixes: 937daafca774b ("powerpc: simple-gpio: use gpiochip data pointer")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for any screwups I've caused...

Yours,
Linus Walleij
