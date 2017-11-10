Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYCY72qLNzDrKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 19:16:26 +1100 (AEDT)
Subject: Re: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
To: Bao Xiaowei <xiaowei.bao@nxp.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <bhelgaas@google.com>, <shawnguo@kernel.org>,
 <madalin.bucur@nxp.com>, <sumit.garg@nxp.com>, <yangbo.lu@nxp.com>,
 <hongtao.jia@nxp.com>, <Yuantian.Tang@nxp.com>, <leoyang.li@nxp.com>,
 <jingoohan1@gmail.com>, <pbrobinson@gmail.com>,
 <songxiaowei@hisilicon.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <Zhiqiang.Hou@nxp.com>, <mingkai.hu@nxp.com>, <Minghuan.Lian@nxp.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-2-xiaowei.bao@nxp.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <20b8f1d2-f817-469f-afbf-66f25d6f8c46@ti.com>
Date: Fri, 10 Nov 2017 11:52:21 +0530
MIME-Version: 1.0
In-Reply-To: <20171110034847.17891-2-xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bao,

On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> Add the property of inbound and outbound windows number for ep
> driver.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
> ---
>  v2:
>  - no change
>  v3:
>  - modify the commit message
>  v4:
>  - no change
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

$subject should start with something like
arm64: dts: ls1046a: **
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06b5e12d04d8..f8332669663c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -674,6 +674,8 @@
>  			device_type = "pci";
>  			dma-coherent;
>  			num-lanes = <4>;
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;

EP specific properties shouldn't be added in RC dt node. Ideally you should
have a separate dt node for RC and EP.

Thanks
Kishon
