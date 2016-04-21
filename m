Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrTN75QNMzDqb0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 05:29:43 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id A6353201C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:29:40 +0000 (UTC)
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
 [209.85.161.175])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B3EA2035D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:29:38 +0000 (UTC)
Received: by mail-yw0-f175.google.com with SMTP id t10so100409482ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 12:29:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1461166339-11109-15-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-15-git-send-email-geert+renesas@glider.be>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 Apr 2016 14:29:18 -0500
Message-ID: <CAL_JsqL7QFpTimE3=+jp1cgsgv0cSjBHr+uOtPOGnxyBN=0=Mg@mail.gmail.com>
Subject: Re: [PATCH 14/14] regulator: ti-abb: DT spelling s/#{address,
 size}-cell/#{address, size}-cells/
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/regulator/ti-abb-regulator.txt         | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt b/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
> index c58db75f959e601f..c3f6546ebac77742 100644
> --- a/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
> @@ -14,8 +14,8 @@ Required Properties:
>    - "setup-address"    - contains setup register address of ABB module (ti,abb-v3)
>    - "int-address"      - contains address of interrupt register for ABB module
>    (also see Optional properties)
> -- #address-cell: should be 0
> -- #size-cell: should be 0
> +- #address-cells: should be 0
> +- #size-cells: should be 0

Looks to me like you can just drop these.

Rob
