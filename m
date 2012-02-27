Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FDDBB6FA9
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 06:50:13 +1100 (EST)
Message-ID: <4F4BDE6D.1060202@freescale.com>
Date: Mon, 27 Feb 2012 13:50:05 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu <yu.liu@freescale.com>
Subject: Re: [PATCH v6 4/4] KVM: PPC: epapr: Update other hypercall invoking
References: <1329988942-19610-1-git-send-email-yu.liu@freescale.com>
 <1329988942-19610-2-git-send-email-yu.liu@freescale.com>
 <1329988942-19610-3-git-send-email-yu.liu@freescale.com>
 <1329988942-19610-4-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329988942-19610-4-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, B07421@freescale.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2012 03:22 AM, Liu Yu wrote:
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 2dcdbc9..99ebdde 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -15,6 +15,7 @@ if VIRT_DRIVERS
>  config FSL_HV_MANAGER
>  	tristate "Freescale hypervisor management driver"
>  	depends on FSL_SOC
> +	select EPAPR_PARAVIRT
>  	help
>            The Freescale hypervisor management driver provides several services
>  	  to drivers and applications related to the Freescale hypervisor:

What about the byte channel driver, and possibly others?

Grep for the hypercalls to make sure you got everything that uses this.

-Scott
