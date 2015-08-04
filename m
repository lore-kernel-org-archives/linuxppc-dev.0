Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0102.outbound.protection.outlook.com [207.46.100.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 989161A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 15:00:39 +1000 (AEST)
Message-ID: <1438664426.2097.75.camel@freescale.com>
Subject: Re: [v3,1/2] powerpc/mpc85xx: Create dts components for the FSL
 QorIQ DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <madalin.bucur@freescale.com>, <linux-kernel@vger.kernel.org>
Date: Tue, 4 Aug 2015 00:00:26 -0500
References: <1438584241-10460-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1438584241-10460-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Resending after bogofilter adjustment on vger.kernel.org]

On Mon, Aug 03, 2015 at 09:44:01AM +0300, Igal.Liberman wrote:
> +     xmdio0:  mdio@f1000{
> +             #address-cells = <1>;
> +             #size-cells = <0>;
> +             compatible = "fsl,fman-xmdio";
> +             reg = <0xf1000 0x1000>;
> +             interrupts = <101 1 0 0>;
> +     };

Why is this <101 1 0 0> and not <101 2 0 0>?  Internal interrupts are
active-high.

> +     mdio0:  mdio@e1120{
> +             #address-cells = <1>;
> +             #size-cells = <0>;
> +             compatible = "fsl,fman-mdio";
> +             reg = <0xe1120 0xee0>;
> +             interrupts = <100 1 0 0>;

Likewise.

-Scott
