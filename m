Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 491A8679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Jun 2006 22:05:09 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FuofK-0000g2-QO
	for linuxppc-embedded@ozlabs.org; Mon, 26 Jun 2006 12:50:02 +0200
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 26 Jun 2006 12:50:02 +0200
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 26 Jun 2006 12:50:02 +0200
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Mon, 26 Jun 2006 12:48:27 +0200
Message-ID: <e7oe1r$k2o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am currently working on a MPC8548-based development system.
Linux kernel version is 2.6.11 with patches delivered from Freescale 
(BSP MPC8548CDS 02/24/2006).

Kernel configuration contains a warning message for CONFIG_PEX:
"This requires hardware modification to work correctly if your CPU 
version < 2.0 and will break the PCI bus. [...]"

I was wondering whether enabling PCIe makes PCI bus functionality 
unusable at all (including kernel functionality for detecting devices 
behind a transparent PCI-to-PCI bridge).

Our setup connects a transparent PLX8516 PCI-to-PCI bridge to the PCIe 
port of the MPC8548 daughter board. Behind that bridge is another PCIe 
capable device.
MPC8548 is configured to run as PCIe host mode.

When trying to lookup the PCIe devices using lspci I can only see the 
PPC itself and the bridge.
However I cannot see the device(s) behind the bridge.

Is there another method for detecting PCI(e) devices?
Is "BSP MPC8548CDS 02/24/2006" the latest version corresponding to that 
hardware?

Thanks in advance,

   Florian
