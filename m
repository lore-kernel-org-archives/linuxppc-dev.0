Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E47BDDF52
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 03:11:06 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JeYDP-0002G8-0H
	for linuxppc-embedded@ozlabs.org; Wed, 26 Mar 2008 09:11:03 -0700
Message-ID: <16304553.post@talk.nabble.com>
Date: Wed, 26 Mar 2008 09:11:03 -0700 (PDT)
From: Amarendra_Reddy <amar1567@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Help on MPC82XX USB Host controller Development using m82xx-hcd.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

We are working on implementation of the USB host controller driver for the
MPC8272ADS (eval board). 

The USB Host controller on MPC8272 chip is neither UHCI nor OHCI compliant. 

We downloaded the project cpm2usb and the patches created by Mr.Mike
Rapoport from http://cpm2usb.sourceforge.net

We integrated the 'm82xx-hcd' into the 2.6.10 source with few changes to usb
data structures (usb_hcd,usb_device,usb_host_endpoint) and to struct
hc_driver. Also updated the function ''tx_err' present in m82xx-hcd.c.


The output from console:
---------------------------------------------------------------------------
NET: Registered protocol family 16
mpc8272ads: Init
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a60 (irq = 43) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
fs_enet.c:v1.0 (Aug 8, 2005)
fs_enet: eth0 Phy @ 0x0, type DM9161 (0x0181b881)
fs_enet: eth1 Phy @ 0x3, type DM9161 (0x0181b881)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
USB Universal Host Controller Interface driver v2.2
sl811: driver sl811-hcd, 06 Dec 2004
=> driver mpc82xx-hcd, 2005
mpc82xx-hcd mpc82xx-hcd3: PQ2 intergrated USB controller v0.1
mpc82xx-hcd mpc82xx-hcd3: new USB bus registered, assigned bus number 1
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
--------------------------------------------------------------------------

I have a little knowledge of USB support by Linux.

If anyone has any clues or faced such a problem, 
it would be of great help if you could reply or give any suggestion.  


Thanks in advance
Amarendra Reddy

-- 
View this message in context: http://www.nabble.com/Help-on-MPC82XX-USB-Host-controller-Development-using-m82xx-hcd.-tp16304553p16304553.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
