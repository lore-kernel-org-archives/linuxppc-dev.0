Return-Path: <linus.walleij@linaro.org>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zc0yN5KqSzF0t2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 23:29:48 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id b198so1823012iof.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 04:29:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122050411.32460-4-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-4-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 13:29:45 +0100
Message-ID: <CACRpkdZLiw=e-XiS9cbQuJGJ2tJVV86qKaLCy2yG==FSENhAHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Mon, Jan 22, 2018 at 6:04 AM, Jonathan Neusch=C3=A4fer
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
> ---
>
> v2:

All looks very good to me, Andy had some additional comments,
once addressed in v3 I will apply this.

You only need to resend this patch as I already applied the DT
bindings.

Yours,
Linus Walleij
