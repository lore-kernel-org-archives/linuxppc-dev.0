Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0B511A009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 10:37:29 +1100 (AEDT)
Date: Tue, 8 Mar 2016 17:37:23 -0600
From: Scott Wood <oss@buserror.net>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com,
 Priyanka.Jain@freescale.com, robh+dt@kernel.org
Message-ID: <20160308233723.GA32122@home.buserror.net>
References: <1452221215-12681-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452221215-12681-1-git-send-email-qiang.zhao@nxp.com>
Subject: Re: [1/3] TDM: Add maxim ds26522 document to bindings
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 08, 2016 at 10:46:53AM +0800, Zhao Qiang wrote:
> Add maxim ds26522 document to
> Documentation/devicetree/bindings/tdm/maxim,ds26522.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/tdm/maxim,ds26522.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tdm/maxim,ds26522.txt
> 
> diff --git a/Documentation/devicetree/bindings/tdm/maxim,ds26522.txt b/Documentation/devicetree/bindings/tdm/maxim,ds26522.txt
> new file mode 100644
> index 0000000..3548c51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tdm/maxim,ds26522.txt
> @@ -0,0 +1,13 @@
> +* Maxim (Dallas) DS26522 Octal T1/E1/J1 Transceiver
> +
> +Required properties:
> +- compatible: Should contain "maxim,ds26522".
> +- reg: SPI CS
> +- spi-max-frequency: SPI bus max frequency.
> +
> +Example:
> +	slic@2 {
> +		compatible = "maxim,ds26522";
> +		reg = <2>;
> +		spi-max-frequency = <2000000>;
> +	};

An almost identical file was added by you in commit
a109752ea6a55c3682b6ac9114a125c5ce7e5353

There is also overlap in the later patches of this set.

Why did you send this again?  What tree are you basing your patches on?

-Scott
