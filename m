Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9387EDDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:10:44 +1100 (EST)
Date: Thu, 29 Nov 2007 22:14:04 -0600
From: Olof Johansson <olof@lixom.net>
To: Li Li <r64360@freescale.com>
Subject: Re: [PATCH] Add MPC837xEMDS PCIE RC mode support
Message-ID: <20071130041404.GB26982@lixom.net>
References: <1196394334.29683.5.camel@Guyver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196394334.29683.5.camel@Guyver>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Nov 30, 2007 at 11:45:34AM +0800, Li Li wrote:

> +	pci2@e0009000 {

Why call it pci2@ (and pci3@ below)? They are clearly identifiable with 
their unit addresses anyway.

> +config PPC_MPC83XX_PCIE
> +	bool "MPC837X PCI Express support"
> +	depends on PCIEPORTBUS && PPC_MPC837x
> +	default n
> +	help
> +	  Enables MPC837x PCI express RC mode

Why have a separate config option for this?

For systems where you don't want PCI-e configured, it should be left
out of the device tree instead.



-Olof
