Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypKKw5hgBzDsG4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 03:22:11 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id f69so7480243oig.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 08:22:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1508245278-5692-1-git-send-email-fabio.estevam@nxp.com>
References: <1508245278-5692-1-git-send-email-fabio.estevam@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Dec 2017 14:22:09 -0200
Message-ID: <CAOMZO5Ai_S7LpY20pH2LoGuQTrX4ZLevfEhvj+LRrK7DG06oNw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: acadia: Fix the 'interrupt-parent' property
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Oct 17, 2017 at 11:01 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> 'interrupts-parent' property does not exist. Fix the typo.
>
> Fixes: 00f3ca740a9c26 ("powerpc/40x: AMCC PowerPC 405EZ Acadia DTS")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/powerpc/boot/dts/acadia.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
> index 57291f6..8626615 100644
> --- a/arch/powerpc/boot/dts/acadia.dts
> +++ b/arch/powerpc/boot/dts/acadia.dts
> @@ -183,7 +183,7 @@
>                         usb@ef603000 {
>                                 compatible = "ohci-be";
>                                 reg = <0xef603000 0x80>;
> -                               interrupts-parent = <&UIC0>;
> +                               interrupt-parent = <&UIC0>;

Any comments?
