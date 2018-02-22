Return-Path: <linus.walleij@linaro.org>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znDs66nMDzF0mJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:57:10 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id l12so5898212ioc.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 04:57:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 13:57:07 +0100
Message-ID: <CACRpkdZKLm2owgVu7-f80dOdQDzQKCbO2Vvh3QHfOpEzndMxxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 linux-gpio@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>,
 Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 9, 2018 at 1:07 PM, Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
>
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
>
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> <---
>
> v3:
> - Do some style cleanups, as suggest by Andy Shevchenko

Patch applied to the GPIO tree for v4.17 with all the review tags.

I just folded the changelog into the commit message, for new
drivers it is sometimes useful to keep these around in
git actually.

If any further changes are needed we can just patch on top
of this.

It's a very pretty driver, good work!

Yours,
Linus Walleij
