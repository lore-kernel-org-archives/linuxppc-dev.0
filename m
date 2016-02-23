Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 861401A07E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 07:23:48 +1100 (AEDT)
Date: Tue, 23 Feb 2016 14:23:42 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/7] QE: Add uqe_serial document to bindings
Message-ID: <20160223202342.GA9008@rob-hp-laptop>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <1455757572-44955-3-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455757572-44955-3-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2016 at 09:06:08AM +0800, Zhao Qiang wrote:
> Add uqe_serial document to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2
> 	- modify tx/rx-clock-name specification
> 
>  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> new file mode 100644
> index 0000000..436c71c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> @@ -0,0 +1,19 @@
> +* Serial
> +
> +Currently defined compatibles:
> +- ucc_uart
> +
> +Properties for ucc_uart:
> +port-number : port number of UCC-UART

How is this used?

> +tx/rx-clock-name : should be "brg1"-"brg16" for internal clock source,
> +		   should be "clk1"-"clk28" for external clock source.

Perhaps you should be using the clock binding here and in other 
bindings?

> +
> +Example:
> +
> +	ucc_serial: ucc@2200 {
> +		device_type = "serial";
> +		compatible = "ucc_uart";
> +		port-number = <1>;
> +		rx-clock-name = "brg2";
> +		tx-clock-name = "brg2";
> +	};
> -- 
> 2.1.0.27.g96db324
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
