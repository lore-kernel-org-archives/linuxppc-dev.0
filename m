Return-Path: <linus.walleij@linaro.org>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTyG15cpQzDsF9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 08:05:45 +1000 (AEST)
Received: by mail-oi0-x22d.google.com with SMTP id y2so46182410oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 15:05:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160905225217.C34571A245A@localhost.localdomain>
References: <20160905225217.C34571A245A@localhost.localdomain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Sep 2016 00:05:42 +0200
Message-ID: <CACRpkda1vj_BGYP2-4aSS=hcY2jkaaJuY59DOjiSt0JUSgBcBw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl/qe: fix gpio save_regs functions
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 6, 2016 at 12:52 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> of_mm_gpiochip_add_data() calls mm_gc->save_regs() before
> setting the data. Therefore ->save_regs() cannot use
> gpiochip_get_data()
>
> An Oops is encountered without this fix.
>
> fixes: 1e714e54b5ca5 ("powerpc: qe_lib-gpio: use gpiochip data pointer")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: <stable@vger.kernel.org>

Aha sorry for my regular screwups. :(
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
