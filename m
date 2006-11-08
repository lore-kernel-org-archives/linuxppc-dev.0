Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id AF09067C51
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 03:01:10 +1100 (EST)
Message-ID: <4551FF39.70701@ru.mvista.com>
Date: Wed, 08 Nov 2006 19:00:57 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Changed gianfar device tree definition to make it more
	flexible
References: <Pine.LNX.4.61.0611071707520.6936@ld0175-tx32.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0611071707520.6936@ld0175-tx32.am.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Andy Fleming wrote:

> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 27b457c..bb1a402 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1193,6 +1193,7 @@ platforms are moved over to use the flat
>  
>      - device_type : Should be "network"
>      - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
> +      (This is deprecated in favor of the feature bits)
>      - compatible : Should be "gianfar"
>      - reg : Offset and length of the register set for the device
>      - mac-address : List of bytes representing the ethernet address of
> @@ -1206,6 +1207,30 @@ platforms are moved over to use the flat
>        services interrupts for this device.
>      - phy-handle : The phandle for the PHY connected to this ethernet
>        controller.
> +    - interface : The interface this ethernet is using.  Current options are:
> +        GMII, MII, RGMII, SGMII, TBI, RMII, and RTBI
> +
> +  Optional properties (features):
> +    - gigabit : Indicates support for 1000 Mbit operation

    There's standard "supported-network-type" property listing supported
speeds/connectors already, why introduce another one?

WBR, Sergei
