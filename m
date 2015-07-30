Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0117.outbound.protection.outlook.com [207.46.100.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47B301A17B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 06:12:39 +1000 (AEST)
Message-ID: <1438287143.2993.367.camel@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpc85xx: Add FSL QorIQ DPAA FMan support
 to the SoC device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <madalin.bucur@freescale.com>, <linux-kernel@vger.kernel.org>
Date: Thu, 30 Jul 2015 15:12:23 -0500
In-Reply-To: <1438230794-10983-1-git-send-email-igal.liberman@freescale.com>
References: <1438230794-10983-1-git-send-email-igal.liberman@freescale.com>
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

On Thu, 2015-07-30 at 07:33 +0300, Igal.Liberman wrote:
> @@ -307,4 +307,117 @@
>               reg = <0xe0000 0x1000>;
>               fsl,has-rstcr;
>       };
> +
> +      fman@100000{
> +             #address-cells = <1>;
> +             #size-cells = <1>;
> +             cell-index = <0>;
> +             ranges = <0 0x100000 0x100000>;
> +             compatible = "fsl,fman";
> +             reg = <0x100000 0x100000>;
> +             interrupts = <24 2 0 0>, <16 2 1 30>;
> +             clock-frequency = <0>;
> +             fsl,qman-channel-range = <0x40 0x7>;

fman is supposed to have clocks/clock-names, not clock-frequency.

-Scott
