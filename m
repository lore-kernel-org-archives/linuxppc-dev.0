Return-Path: <linus.walleij@linaro.org>
Received: from mail-it0-x234.google.com (mail-it0-x234.google.com
 [IPv6:2607:f8b0:4001:c0b::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zc0v84X3FzF13n
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 23:26:59 +1100 (AEDT)
Received: by mail-it0-x234.google.com with SMTP id i144so2047556ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 04:26:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122050411.32460-5-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-5-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 13:26:57 +0100
Message-ID: <CACRpkdYNJhEFJiYbt72StHFD2udCH=6F7M2XYQHrBTKzAVCnxA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: gpio: Add binding for Wii GPIO
 controller
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 linux-gpio@vger.kernel.org,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
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

> The Nintendo Wii game console has a GPIO controller, which is used for
> the optical disk slot LED, buttons, poweroff, etc. This patch adds a
> binding for this GPIO controller.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> v2:

Patch applied for 4.17.

Yours,
Linus Walleij
