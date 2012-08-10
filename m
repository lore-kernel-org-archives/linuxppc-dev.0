Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8711F2C00E3
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2012 08:34:12 +1000 (EST)
Message-ID: <50258C5D.5070108@freescale.com>
Date: Fri, 10 Aug 2012 17:34:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: add the Fman device tree template
 include files
References: <1344637896-14267-1-git-send-email-timur@freescale.com>
In-Reply-To: <1344637896-14267-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
 ddaney.cavm@gmail.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2012 05:31 PM, Timur Tabi wrote:
> Introduce the template include files for the Freecale Frame Manager (Fman).
> An SOC can have up to two Fman devices, and each Fman can have up to
> five 1G Ethernet MACs and one 10G Ethernet MAC.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0-10g-0.dtsi |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-0.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-1.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-2.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-3.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-4.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi       |  140 +++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1-10g-0.dtsi |   54 ++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-0.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-1.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-2.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-3.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-4.dtsi  |   63 +++++++++
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi       |  140 +++++++++++++++++++++
>  14 files changed, 1027 insertions(+), 0 deletions(-)

Where's the binding document for all this?  Why isn't devicetree-discuss
on CC?

-Scott
