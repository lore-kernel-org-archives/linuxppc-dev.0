Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 30DD0DE10A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 02:58:36 +1000 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 571253CC062
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 18:58:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 2D3E9E3C25
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 18:56:39 +0200 (CEST)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id E8E5CE3C25
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 18:56:38 +0200 (CEST)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 595DF53D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 18:58:04 +0200 (CEST)
Message-ID: <480E1939.6000701@matrix-vision.de>
Date: Tue, 22 Apr 2008 18:58:33 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Question on MPC83xx interrupts
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

I'm currently running a MPC8343 based board.

Looks like I'm having problems with IRQs of a PCI device.

/proc/interrupts give :

           CPU0
 16:        554   IPIC   Level     i2c-mpc
 17:         11   IPIC   Level     i2c-mpc
 18:        134   IPIC   Level     ath
 19:       1557   IPIC   Level     serial
 21:        341   IPIC   Level     mpc83xx_spi
 38:          0   IPIC   Level     ehci_hcd:usb1
BAD:          2



I wonder if the IRQ number should match the vector of the datasheet ... 
giving :

14  -> I2C1
15  -> I2C2
16  -> SPI
38  -> USB DR

The "ath" is a PCI Ath5k WiFi module connected to IRQ1, i.e. mapped to 
vector 17.


Are the IRQ numbers shifted/mapped/scrambled in any way ?

Can anyone shed some light on this ?


Cheers,
Andre Schwarz
Matrix Vision

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
