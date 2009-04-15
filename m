Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0FE50DDF39
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:50:11 +1000 (EST)
Date: Wed, 15 Apr 2009 20:50:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add P2020DS board support
Message-ID: <20090415165009.GA10214@oksana.dev.rtsoft.ru>
References: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1239810564-8403-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ted Peters <ted.peters@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 10:49:24AM -0500, Kumar Gala wrote:
> From: Ted Peters <ted.peters@freescale.com>
> 
> The P2020 is a dual e500v2 core based SOC with:
> * 3 PCIe controllers
> * 2 General purpose DMA controllers
> * 2 sRIO controllers
> * 3 eTSECS
> * USB 2.0
> * SDHC
> * SPI, I2C, DUART
> * enhanced localbus
> * and optional Security (P2020E) security w/XOR acceleration
> 
> The p2020 DS reference board is pretty similar to the existing MPC85xx
> DS boards and has a ULI 1575 connected on one of the PCIe controllers.
> 
> Signed-off-by: Ted Peters <Ted.Peters@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
[...]
> +	soc@ffe00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";

Sorry for bringing this up again... But can we decide on soc's
compatible scheme and finally remove the device_type = "soc"
for new boards? "fsl,p2020-soc", "fsl,soc", "simple-bus" maybe?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
