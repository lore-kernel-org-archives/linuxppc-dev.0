Return-Path: <linus.walleij@linaro.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF2411A1BEF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 18:22:42 +1000 (AEST)
Received: by obbop1 with SMTP id op1so93986059obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2015 01:22:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1438334166-12579-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1438334166-12579-1-git-send-email-u.kleine-koenig@pengutronix.de>
Date: Mon, 3 Aug 2015 10:22:40 +0200
Message-ID: <CACRpkdbL14+oP6wb4C7C1KndmeJHNNGytu9xvx4Wxns=zXUDKg@mail.gmail.com>
Subject: Re: [PATCH RESENT] powerpc: dts: don't fall back to fsl, pq3-gpio for
 fsl,mpc8572-gpio devices
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Alexandre Courbot <gnurou@gmail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 31, 2015 at 11:16 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> While the handling of fsl,pq3-gpio and fsl,mpc8572-gpio is done in the
> same driver and the two hardly differ, the latter controller needs a
> workaround for an erratum in the gpio_get callback. To make this
> difference more explicit remove fsl,pq3-gpio from the list of
> compatibles for mpc8572 machines.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
