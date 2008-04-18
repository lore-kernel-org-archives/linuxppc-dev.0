Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFF41DE35A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 22:52:01 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3ICpuwI005205
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:51:57 -0700 (MST)
Message-Id: <2E5B7A5C-F193-4A25-A329-8C3CC9002102@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1208588876-23103-1-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Fix the wrong serial1 interrupt for 8610 board
Date: Fri, 18 Apr 2008 07:51:54 -0500
References: <1208588876-23103-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2008, at 2:07 AM, Jason Jin wrote:
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8610_hpcd.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/ 
> boot/dts/mpc8610_hpcd.dts
> index 16c947b..97fdb01 100644
> --- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> +++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> @@ -100,7 +100,7 @@
> 			compatible = "ns16550";
> 			reg = <0x4600 0x100>;
> 			clock-frequency = <0>;
> -			interrupts = <28 2>;
> +			interrupts = <42 2>;

I've converted the .dts to v1 syntax but I'll fix this when I apply  
since its trivial.

>
> 			interrupt-parent = <&mpic>;
> 		};

- k
