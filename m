Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0110.outbound.protection.outlook.com [207.46.100.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E01901A1706
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 01:40:46 +1100 (AEDT)
Message-ID: <1450708833.18314.35.camel@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <madalin.bucur@freescale.com>, <shaohui.xie@freescale.com>
Date: Mon, 21 Dec 2015 08:40:33 -0600
In-Reply-To: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
References: <1450655851-6556-1-git-send-email-igal.liberman@freescale.com>
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

On Mon, 2015-12-21 at 01:57 +0200, igal.liberman@freescale.com wrote:
> From: Igal Liberman <igal.liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> 
> This patch adds pcsphy node to FManV3 device tree.
> Based on: https://patchwork.ozlabs.org/patch/503921/
> ---
>  .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |    5 +++++
>  .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |    5 +++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |    5 +++++
>  18 files changed, 90 insertions(+)

Binding?

-Scott
