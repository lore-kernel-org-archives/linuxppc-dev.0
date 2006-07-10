Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AB3C679E0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 04:35:34 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G00b0-0006O7-4c
	for linuxppc-dev@ozlabs.org; Mon, 10 Jul 2006 20:35:02 +0200
Received: from 24-159-197-73.dhcp.roch.mn.charter.com ([24.159.197.73])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 20:35:02 +0200
Received: from drfickle by 24-159-197-73.dhcp.roch.mn.charter.com with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 20:35:02 +0200
To: linuxppc-dev@ozlabs.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: Linux v2.6.18-rc1
Date: Mon, 10 Jul 2006 13:30:31 -0500
Message-ID: <pan.2006.07.10.18.30.30.338580@us.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
	<1152549482.2658.29.camel@flooterbu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 10 Jul 2006 11:38:02 -0500, Steve Fox wrote:

> Also, booting with ide=nodma, as Alan suggested to Will, did not help.

I'm not sure if it was due to using the nodma parameter or not, but I did
get a few more details during this boot. No idea if they're useful or not.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2 ide:
Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:04.1 AMD8111: chipset revision
3 AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller AMD8111: 100% native
mode on irq 17
    ide0: BM-DMA at 0x7c00-0x7c07, BIOS settings: hda:pio, hdb:pio ide1:
    BM-DMA at 0x7c08-0x7c0f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4019GAXB, ATA DISK drive ide0 at 0x7400-0x7407,0x6c02 on
irq 17 hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: 78140160 sectors (40007 MB), CHS=65535/16/63 hda: lost interrupt hda:
cache flushes supported
 hda:<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 hda1 hda2 hda3 hda4 <<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
 hda5<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt


-- 

Steve Fox
IBM Linux Technology Center
