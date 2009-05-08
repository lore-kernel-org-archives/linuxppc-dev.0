Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 621DEDDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 23:35:17 +1000 (EST)
Message-ID: <4A04352E.9010905@ru.mvista.com>
Date: Fri, 08 May 2009 17:35:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 3/3 v3] Add 4xx SATA dts node documentation
References: <1241632186-2613-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1241632186-2613-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Feng Kan wrote:

> Signed-off-by: Feng Kan <fkan@amcc.com>

[...]

> diff --git a/Documentation/powerpc/dts-bindings/4xx/sata.txt b/Documentation/powerpc/dts-bindings/4xx/sata.txt
> new file mode 100644
> index 0000000..3ce00d0
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/4xx/sata.txt
> @@ -0,0 +1,24 @@
> +AMCC SoC SATA Support 
> +
> +This following is only for the 460ex support for Designware SATA core
> +
> +Required properties:
> +- compatible : "amcc,sata-460ex".
> +- reg : the first set defines SATA controller register, the second set
> +        is for the AHB DMA controller for SATA.
> +- interrupt-parent: UIC3
> +- interrupts: one for SATA and one for the DMA
> +
> +Notes:
> +The SATA is only available when the first PCIe port is disabled.
> +
> +Example:
> +
> +SATA0: sata@bffd1000 {
> +	compatible = "amcc,sata-460ex";
> +        reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;

     Spaces ISO tab.

> +	interrupt-parent = <&UIC3>;
> +	interrupts = <0 4       /* SATA */
> +		      5 4>;     /* AHBDMA */
> +};
> +

MBR, Sergei
