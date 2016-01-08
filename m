Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 42FFA1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 07:12:30 +1100 (AEDT)
Date: Fri, 8 Jan 2016 14:12:25 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Priyanka.Jain@freescale.com,
 oss@buserror.net
Subject: Re: [PATCH 3/6] QE: Add uqe_serial document to bindings
Message-ID: <20160108201225.GA9813@rob-hp-laptop>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
 <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 08, 2016 at 10:18:11AM +0800, Zhao Qiang wrote:
> Add uqe_serial document to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> new file mode 100644
> index 0000000..e677599
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> @@ -0,0 +1,20 @@
> +* Serial
> +
> +Currently defined compatibles:
> +- ucc_uart
> +
> +Properties for ucc_uart:
> +device_type : which type the device is

Drop this please.

> +port-number : port number of UCC-UART

Use aliases instead.

> +rx-clock-name : which clock QE use for RX
> +tx-clock-name : which clock QE use for TX

These should use the clock binding.

> +
> +Example:
> +
> +	serial: ucc@2200 {
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
