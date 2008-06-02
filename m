Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id C8357DDEED
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 18:19:44 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 837B03CC040
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 10:19:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 686C1E3C09
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 10:19:22 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 33464E3C09
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 10:19:22 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id F055E526
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 10:18:58 +0200 (CEST)
Message-ID: <4843AD1C.4010901@matrix-vision.de>
Date: Mon, 02 Jun 2008 10:19:40 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: slow MMC over SPI
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

has anybody made some investigations about performance of a SD/MMC card
on SPI ?

Actually I'm using various cards (different speed classes) on an SPI bus
of a MPC8343 cpu.
Everything is working fine basically, i.e. card is detected properly and
block device can be mounted and used.

SPI clock is adjusted to the card's capabilities and is running quite
fast (>30MHz).

But between consecutive reads/writes there's a fixed gap of 2us thus
yielding a poor performance of approx. 300KBytes/sec.
The spi bus is utilized only ~10%.

Any ideas where this comes from ?
Ist it a fixed delay regarding to some kind of spec or is it possibly a
spi driver/mmc layer issue ?


regards,
Andre Schwarz

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
