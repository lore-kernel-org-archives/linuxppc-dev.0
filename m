Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41CEC6B0.5020106@free.fr>
References: <41CEC6B0.5020106@free.fr>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 09:52:06 +0100
Message-Id: <1104137527.5615.20.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PATCH uninorth3 (G5) agp support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +/* The following seems to only be used only on U3 <j.glisse@free.fr> */
> +#define UNI_N_CFG_GART_SYNCMODE		0x00040000
> +#define UNI_N_CFG_GART_PERFRD		0x00080000
> +#define UNI_N_CFG_GART_B2BGNT		0x00200000
> +#define UNI_N_CFG_GART_FASTDDR		0x00400000

Please, call them U3_*

>  /* My understanding of UniNorth AGP as of UniNorth rev 1.0x,
>   * revision 1.5 (x4 AGP) may need further changes.
> diff -Naur linux/include/linux/pci_ids.h linux-new/include/linux/pci_ids.h
> --- linux/include/linux/pci_ids.h	2004-12-26 14:40:05.000000000 +0100
> +++ linux-new/include/linux/pci_ids.h	2004-12-26 14:50:19.000000000 +0100
> @@ -842,6 +842,7 @@
>  #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032
>  #define PCI_DEVIEC_ID_APPLE_UNI_N_ATA	0x0033
>  #define PCI_DEVICE_ID_APPLE_UNI_N_AGP2	0x0034
> +#define PCI_DEVICE_ID_APPLE_UNI_N_AGP3	0x0059
>  #define PCI_DEVICE_ID_APPLE_IPID_ATA100	0x003b
>  #define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
>  #define PCI_DEVICE_ID_APPLE_K2_ATA100	0x0043

Plase, call it PCI_DEVICE_ID_APPLE_U3_AGP

The name of the chip is not "UniNorth 3" but "U3" :) (Same goes with U2
btw).

Ben.
