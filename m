Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 4BBE7679FB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 21:51:17 +1000 (EST)
Date: Wed, 9 Aug 2006 13:51:09 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: boot problems on pseries
Message-ID: <20060809115109.GA4290@aepfle.de>
References: <20060809013609.GA10876@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060809013609.GA10876@ca-server1.us.oracle.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2006 at 06:36:09PM -0700, Mark Fasheh wrote:

> Recently, I discovered that newer kernels would no longer fully boot.

The IDE controller got irq32 in older kernels, now it gets irq17.
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:04.1
AMD8111: chipset revision 3
AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller
AMD8111: 100% native mode on irq 17
    ide0: BM-DMA at 0x7c00-0x7c07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7c08-0x7c0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK6026GAXB, ATA DISK drive
ide0 at 0x7400-0x7407,0x6c02 on irq 17
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt
...
