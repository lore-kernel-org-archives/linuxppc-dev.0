Return-Path: <robherring2@gmail.com>
Received: from mail-vc0-x229.google.com (mail-vc0-x229.google.com
 [IPv6:2607:f8b0:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E34E14007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 00:56:50 +1100 (EST)
Received: by mail-vc0-f169.google.com with SMTP id ik5so573628vcb.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Mar 2014 06:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395754915-14534-2-git-send-email-valentin.longchamp@keymile.com>
References: <1395754915-14534-1-git-send-email-valentin.longchamp@keymile.com>
 <1395754915-14534-2-git-send-email-valentin.longchamp@keymile.com>
Date: Tue, 25 Mar 2014 08:56:45 -0500
Message-ID: <CAL_JsqJScfzfaCiNWU5zqjvpebxk3geEnm2pPwvBq+m0mWR07w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: add Zarlink to the vendor
 prefixes
From: Rob Herring <robherring2@gmail.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2014 at 8:41 AM, Valentin Longchamp
<valentin.longchamp@keymile.com> wrote:
> Even though the company belongs to Microsemi, many chips are still
> labeled as Zarlink. Among them is the family of network clock generators,
> the zl3034x.
>
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>

Acked-by: Rob Herring <robh@kernel.org>

>
> ---
> Changes in v3: None
> Changes in v2:
> - add a patch so that the Zarlink vendor prefix is defined
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 40ce2df..4a6eba0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -95,3 +95,4 @@ winbond Winbond Electronics corp.
>  wlf    Wolfson Microelectronics
>  wm     Wondermedia Technologies, Inc.
>  xlnx   Xilinx
> +zarlink        Zarlink Semiconductor
> --
> 1.8.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
