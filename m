Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2C21679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:04:47 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626D623@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626D623@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7415A060-C717-4592-92AC-5863002404FC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 6/10]  Add  Tundra pci vendor and device ID
Date: Wed, 17 May 2006 11:04:52 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:

> Add Tundra Semiconductor pci host bridge vendor ID and device ID
>
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

Did you guys submit http://pciids.sourceforge.net/ ?

- k

> ---
>
>  include/linux/pci_ids.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> 14bddf6670ca982d5cee57afa472d2199e2170fc
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d6fe048..c39fcfc 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2276,3 +2276,7 @@ #define PCI_DEVICE_ID_RME_DIGI32	0x9896
>  #define PCI_DEVICE_ID_RME_DIGI32_PRO	0x9897
>  #define PCI_DEVICE_ID_RME_DIGI32_8	0x9898
>
> +#define PCI_VENDOR_ID_TUNDRA		0x10e3
> +#define PCI_DEVICE_ID_TUNDRA_CA91C042	0x0000
> +#define PCI_DEVICE_ID_TUNDRA_TSI108	0x0108
> +#define PCI_DEVICE_ID_TUNDRA_TSI109	0xA108
> -- 
> 1.3.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
