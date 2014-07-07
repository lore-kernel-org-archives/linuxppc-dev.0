Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 202561A0009
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 04:55:16 +1000 (EST)
Message-ID: <1404759301.21434.145.camel@snotra.buserror.net>
Subject: Re: [PATCH] of: Add vendor prefix for EON Corporation
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Mon, 7 Jul 2014 13:55:01 -0500
In-Reply-To: <1404725359-6754-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1404725359-6754-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-07 at 17:29 +0800, Shengzhou Liu wrote:
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Again, please CC all relevant mailing lists.  Where is the devicetree
list?  And mention why this patch is relevant to PPC.

-Scott

> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 1a6793b..3c10a21 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -42,6 +42,7 @@ ebv	EBV Elektronik
>  edt	Emerging Display Technologies
>  emmicro	EM Microelectronic
>  epfl	Ecole Polytechnique Fédérale de Lausanne
> +eon	Eon Silicon Solution, Inc.
>  epson	Seiko Epson Corp.
>  est	ESTeem Wireless Modems
>  eukrea  Eukréa Electromatique
