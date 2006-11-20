Return-Path: <goudard@esrf.fr>
Received: from out.esrf.fr (firewall.embl-grenoble.fr [193.49.43.1])
	by ozlabs.org (Postfix) with ESMTP id 6227467D45
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 10:16:46 +1100 (EST)
Received: (from uucp@localhost) by out.esrf.fr (1.0.0) id kAKBht910599
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 12:43:55 +0100 (MET)
Subject: Memec v4fx12lc - problem booting linux on ppc
From: Olivier Goudard <goudard@esrf.fr>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 20 Nov 2006 12:42:26 +0100
Message-Id: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>
Mime-Version: 1.0
Cc: andy.gotz@esrf.fr
Reply-To: goudard@esrf.fr
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

we have a v4fx12lc fpga board from memec which we are trying to get
Linux to boot on the ppc processor. We have generated a linux kernel for
nfs using the MontaVista support package. We generate a bitfile with the
following hardware peripherals in it :

RS232
Ethernet_MAC
Led_4bit
Push_buttons_3bits
DIP_switches_8bit
OPB_INTC_0

When we download the linux image with xmd we see nothing on the screen.
When we type "run" nothing appears on the screen and Linux does not
boot.

Has anyone had a similar problem ? We are stuck! Any ideas would be
appreciated.

We can boot a linux ramdisk kernel provided by Memec on the same board
using their bitfile. So the board seems to be working in general.

Thansk for any pointers and excuse us if we are posting to the wrong
list (this is the only list we could find which seemed useful) ! 

Olivier Goudard
