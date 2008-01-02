Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 15815DDE36
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:42:48 +1100 (EST)
Date: Wed, 2 Jan 2008 09:51:10 -0600
From: Olof Johansson <olof@lixom.net>
To: Li Li <r64360@freescale.com>
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
Message-ID: <20080102155110.GA15405@lixom.net>
References: <1199272605.22416.8.camel@Guyver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199272605.22416.8.camel@Guyver>
Cc: Wood Scott <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	kim phillips <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 07:16:45PM +0800, Li Li wrote:
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1ee009e..f84caa7 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2111,6 +2111,10 @@
>  #define PCI_DEVICE_ID_TDI_EHCI          0x0101
>  
>  #define PCI_VENDOR_ID_FREESCALE		0x1957
> +#define PCI_DEVICE_ID_MPC8378E		0x00c4
> +#define PCI_DEVICE_ID_MPC8378		0x00c5
> +#define PCI_DEVICE_ID_MPC8377E		0x00c6
> +#define PCI_DEVICE_ID_MPC8377		0x00c7
>  #define PCI_DEVICE_ID_MPC8548E		0x0012
>  #define PCI_DEVICE_ID_MPC8548		0x0013
>  #define PCI_DEVICE_ID_MPC8543E		0x0014

In general it's not needed to add device ID's to the global table,
especially when they're only used once or twice. Just use the hex constant
in the driver instead.


-Olof
