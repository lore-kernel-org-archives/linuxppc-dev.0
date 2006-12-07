Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A152F67CD8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 08:58:14 +1100 (EST)
In-Reply-To: <20061207173353.GD22989@ld0162-tx32.am.freescale.net>
References: <20061207173353.GD22989@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <161D7B81-B884-4C75-B42E-1627CA538918@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: Document device nodes for I2C devices.
Date: Thu, 7 Dec 2006 15:58:02 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2006, at 11:33 AM, Scott Wood wrote:

> Document the use of device trees to describe devices on an I2C bus,  
> which
> will be used with David Brownell's "new style" I2C binding patches.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   34 +++++++++++++++ 
> +++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 27b457c..092b8f3 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1277,6 +1277,8 @@ platforms are moved over to use the flat
>
>     e) I2C
>
> +   e1) I2C Controller
> +
>     Required properties :
>
>      - device_type : Should be "i2c"
> @@ -1297,6 +1299,10 @@ platforms are moved over to use the flat
>        a digital filter sampling rate register
>      - fsl5200-clocking : boolean; if defined, indicated that this  
> device
>        uses the FSL 5200 clocking mechanism.
> +    - #address-cells : should exist and be 1 if I2C devices are  
> declared
> +      in the device tree.
> +    - #size-cells : should exist and be 0 if I2C devices are declared
> +      in the device tree.
>
>     Example :
>
> @@ -1309,6 +1315,34 @@ platforms are moved over to use the flat
>  		dfsrr;
>  	};
>
> +   e2) I2C Devices
> +
> +   Required properties :
> +
> +    - reg : I2C address for the device

Is this a 7-bit or 8-bit padded address?

- kumar
