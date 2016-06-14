Return-Path: <linus.walleij@linaro.org>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL8r0d1pzDqkw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:58:52 +1000 (AEST)
Received: by mail-oi0-x230.google.com with SMTP id d132so139188456oig.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 23:58:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160613200211.14790-2-afd@ti.com>
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-2-afd@ti.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Jun 2016 08:58:49 +0200
Message-ID: <CACRpkdaEkCzp3W4x3HSurpHb1qtkJp-SvWCAQivuL3x8CBY-iQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] gpio: Only descend into gpio directory when
 CONFIG_GPIOLIB is set
To: "Andrew F. Davis" <afd@ti.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
 Sebastian Reichel <sre@kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 Rusty Russell <rusty@rustcorp.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Lauro Ramos Venancio <lauro.venancio@openbossa.org>,
 Aloisio Almeida Jr <aloisio.almeida@openbossa.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 lguest@lists.ozlabs.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 13, 2016 at 10:02 PM, Andrew F. Davis <afd@ti.com> wrote:

> When CONFIG_GPIOLIB is not set make will still descend into the gpio
> directory but nothing will be built. This produces unneeded build
> artifacts and messages in addition to slowing the build. Fix this here.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Patch applied. Strange that this went unnoticed for years.

Yours,
Linus Walleij
