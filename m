Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 567EC2C0398
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 00:34:36 +1100 (EST)
Date: Thu, 7 Mar 2013 13:34:21 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Sandeep Singh <Sandeep@freescale.com>
Subject: Re: [PATCH 1/4] Device tree entry for Freescale TDM controller
Message-ID: <20130307133421.GA4977@n2100.arm.linux.org.uk>
References: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362655668-26721-1-git-send-email-Sandeep@freescale.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I know I'm probably missing something... but... why are these patches
copied to the ARM list?  They appear to be PowerPC patches.

On Thu, Mar 07, 2013 at 04:57:45PM +0530, Sandeep Singh wrote:
> Added dtsi file for Freescale TDM controller.
> This controller is available on many Freescale SOCs like MPC8315, P1020, P1010,
> P1022 and P1024
> Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi |   42 +++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> 
> diff --git a/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> new file mode 100644
> index 0000000..e89f637
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/pq3-tdm1.0-0.dtsi
> @@ -0,0 +1,42 @@
> +/*
> + * PQ3 TDM device tree stub [ controller @ offset 0x16000 ]
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +tdm@16000 {
> +	compatible = "fsl,tdm1.0";
> +	reg = <0x16000 0x200 0x2c000 0x2000>;
> +	clock-frequency = <0>;
> +	tdm_tx_clk = <2048000>;
> +	interrupts = <62 8 0 0>;
> +	fsl,max-time-slots = <128>;
> +};
> -- 
> 1.7.6.GIT
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
