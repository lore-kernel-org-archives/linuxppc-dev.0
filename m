Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41D00564.6010507@free.fr>
References: <41CEC6B0.5020106@free.fr> <1104137527.5615.20.camel@gaston>
	<41D00564.6010507@free.fr>
Content-Type: text/plain
Message-Id: <1104778599.14049.64.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 12:56:39 -0600
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH uninorth3 (G5) agp support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-12-27 at 06:51, Jerome Glisse wrote:

>  /* My understanding of UniNorth AGP as of UniNorth rev 1.0x,
>   * revision 1.5 (x4 AGP) may need further changes.
> diff -Naur linux/include/linux/pci_ids.h linux-new/include/linux/pci_ids.h
> --- linux/include/linux/pci_ids.h	2004-12-26 14:40:05.000000000 +0100
> +++ linux-new/include/linux/pci_ids.h	2004-12-27 13:40:50.121003792 +0100
> @@ -842,6 +842,7 @@
>  #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032

>  #define PCI_DEVIEC_ID_APPLE_UNI_N_ATA	0x0033

>  #define PCI_DEVICE_ID_APPLE_UNI_N_AGP2	0x0034
> +#define PCI_DEVICE_ID_APPLE_U3_AGP	0x0059
>  #define PCI_DEVICE_ID_APPLE_IPID_ATA100	0x003b
>  #define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
>  #define PCI_DEVICE_ID_APPLE_K2_ATA100	0x0043

So, did 0x0033's symbol need to be spelled consistently too?
NB: PCI_DEVIEC_

Thanks,
jdl
