Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9983CDDEBC
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:58:25 +1100 (EST)
Message-Id: <9AD13D2E-B57F-4F19-B89C-C8A83157E0F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080221195021.GC12896@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [USB POWERPC] ehci-fsl: add PPC_MPC837x to default y
Date: Thu, 21 Feb 2008 13:58:18 -0600
References: <20080221195021.GC12896@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 21, 2008, at 1:50 PM, Anton Vorontsov wrote:

> Without this patch it's impossible to select ehci-fsl on PPC_MPC837x.
> Another option would be to convert USB_EHCI_FSL to verbose bool,
> but I presume EHCI_FSL is purposely made silent.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/usb/host/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index d97b16b..33da056 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -72,7 +72,7 @@ config USB_EHCI_FSL
> 	bool
> 	depends on USB_EHCI_HCD
> 	select USB_EHCI_ROOT_HUB_TT
> -	default y if MPC834x || PPC_MPC831x
> +	default y if MPC834x || PPC_MPC831x || PPC_MPC837x

Can we just change this to FSL_SOC

- k
