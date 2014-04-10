Return-Path: <linus.walleij@linaro.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE685140085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 02:30:20 +1000 (EST)
Received: by mail-ob0-f174.google.com with SMTP id wo20so4648439obc.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 09:30:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396156455-4225-1-git-send-email-shc_work@mail.ru>
References: <1396156455-4225-1-git-send-email-shc_work@mail.ru>
Date: Thu, 10 Apr 2014 18:30:16 +0200
Message-ID: <CACRpkdZMabAQuribdmt=bK_1RF1_oSOeiEquXAuxyq3adtE8-g@mail.gmail.com>
Subject: Re: [PATCH] gpio: ge: Convert to platform driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Alexander Shiyan <shc_work@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Alexandre Courbot <gnurou@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 30, 2014 at 7:14 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> This patch converts GE I/O FPGA GPIO driver to platform driver.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
> Only compile tested.

Isn't it necessary to also patch affected platforms to add this
device either as platform device or in their device trees?

Yours,
Linus Walleij
