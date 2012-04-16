Return-Path: <linus.walleij@linaro.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A2955B6FDF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 18:26:05 +1000 (EST)
Received: by ggni2 with SMTP id i2so2413587ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 01:26:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120416081532.GA3238@opensource.wolfsonmicro.com>
References: <1334483574-3997-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdZ8yH1ZSG-nQ9dLm0TipHS-jZDuxwqohUC=LGH9V-5q4w@mail.gmail.com>
 <20120416081532.GA3238@opensource.wolfsonmicro.com>
Date: Mon, 16 Apr 2012 10:26:02 +0200
Message-ID: <CACRpkdb8q4bKSBctBV0V5KrbS-r-P_b_+N75UV58ryxK+jz+8A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
From: Linus Walleij <linus.walleij@linaro.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Grant Likely <grant@secretlab.ca>,
 linux-ia64@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>,
 Chris Zankel <chris@zankel.net>, microblaze-uclinux@itee.uq.edu.au,
 linux@lists.openrisc.net, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2012 at 10:15 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Apr 16, 2012 at 09:21:58AM +0200, Linus Walleij wrote:
>
>> This looks good but I think we need to page the alpha, ia64, m68k, micro=
blaze,
>> openrisc etc subarch maintainers on this patch so they have their say.
>
> That's why I CCed linux-arch, to get all the architecture maintainers
> included. =A0vger would get upset if I CCed everyone individually.

Oh I missed it. I looped in a few maintainers and arch lists anyway.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
