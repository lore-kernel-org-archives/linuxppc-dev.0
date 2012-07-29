Return-Path: <linus.walleij@linaro.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 07C052C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 02:13:32 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so1648134vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2012 09:13:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343034810-3386-9-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-9-git-send-email-u.kleine-koenig@pengutronix.de>
Date: Sun, 29 Jul 2012 18:13:29 +0200
Message-ID: <CACRpkdZqG7E6bsgGFQz_+2aC6FNNV_egOorzKYGtHQJk-fhhqg@mail.gmail.com>
Subject: Re: [PATCH 08/25] gpio/mpc8xxx: add a const qualifier
From: Linus Walleij <linus.walleij@linaro.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Walleij <linus.walleij@stericsson.com>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>, kernel@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2012 at 11:13 AM, Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> wrote:

> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/gpio/gpio-mpc8xxx.c: In function 'mpc8xxx_add_controller'=
:
>         drivers/gpio/gpio-mpc8xxx.c:360:30: warning: assignment discards =
'const' qualifier from pointer target type [enabled by default]
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
