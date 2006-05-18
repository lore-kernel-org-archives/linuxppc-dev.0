Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (unknown [192.88.158.102])
	by ozlabs.org (Postfix) with ESMTP id EBEE067A3A
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 14:50:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k4I5AlRF005931
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:10:47 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4I4osbc024829
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 23:50:55 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C026E@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 6/10]  Add  Tundra pci vendor and device ID
Date: Thu, 18 May 2006 12:50:52 +0800
MIME-Version: 1.0
Content-Type: text/plain
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


VENDOR_ID_TUNDRA and PCI_DEVICE_ID_TUNDRA_CA91C042 have been
in pciids list. 
we will summit PCI_DEVICE_ID_TUNDRA_TSI108 and
PCI_DEVICE_ID_TUNDRA_TSI109.
Dose the pci.ids file there will appear in the new kernel release?

Roy

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
