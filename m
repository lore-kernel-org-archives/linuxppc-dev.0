Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shcyz1MwwzDrPP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 16:44:42 +1000 (AEST)
Date: Sun, 25 Sep 2016 01:44:32 -0500
From: Scott Wood <oss@buserror.net>
To: Andy Fleming <afleming@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com,
 aperez@alexperez.com
Message-ID: <20160925064432.GA15346@home.buserror.net>
References: <1473189119-29458-2-git-send-email-afleming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473189119-29458-2-git-send-email-afleming@gmail.com>
Subject: Re: [1/3] cyrus: Add poweroff/reset support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2016 at 02:11:57PM -0500, Andy Fleming wrote:
> Cyrus uses GPIOs to complete board shutdown/reset.
> Add nodes to indicate that support to the device tree.
> 
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> ---
>  arch/powerpc/boot/dts/fsl/cyrus_p5020.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> index c603390..e417aaa 100644
> --- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> +++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
> @@ -150,6 +150,17 @@
>  				  0 0x00010000>;
>  		};
>  	};
> +
> +        gpio-poweroff {
> +                compatible = "gpio-poweroff";
> +                gpios = <&gpio0 3 1>;
> +        };
> +
> +        gpio-restart {
> +                compatible = "gpio-restart";
> +                gpios = <&gpio0 2 1>;
> +        };
> +
>  };

Whitespace

-Scott
