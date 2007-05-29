Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A666DDFFE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 06:44:49 +1000 (EST)
In-Reply-To: <1179805110272-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17B6534B-3C1C-433D-8875-1C2255E79D98@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Tue, 29 May 2007 15:39:48 -0500
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2007, at 10:38 PM, Zhang Wei wrote:

> Add uli1575 pci-bridge sector. It fixes the issue of ULI1575 not  
> found on rev.2 board.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts      |    6 ++++++
>  arch/powerpc/boot/dts/mpc8641_hpcn_srio.dts |    6 ++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/ 
> boot/dts/mpc8641_hpcn.dts
> index 260b264..04626b1 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -297,6 +297,12 @@
>  				interrupts = <49 2>;
>  				interrupt-parent = <&mpic>;
>  			};
> +			uli1575: uli1575@100 {

is this the right address?

> +				reg = <0 0 0 0 0>;
> +				pci_bridge@200 {
> +					reg = <0 0 0 0 0>;
> +				};
> +			};
>
>  		};

Can someone look at merging this with Wade's patch to add the ISA  
devices

- k
