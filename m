Return-Path: <vprashant@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id 0B32167B4C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 04:09:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: USB on MPC8349EMDS
Date: Tue, 2 May 2006 10:57:44 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B401551C7A@monk.echelon.echcorp.com>
From: "Prashant Viswanathan" <vprashant@echelon.com>
To: <linuxppc-embedded@ozlabs.org>
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

I have linux kernel (2.6.11) from Freescale running on the MPC8349EMDS.
I am using the BSP from Freescale which is supposed to have USB support.

However, I seem to be having problems with USB host support.

When I insert a USB Mass storage device (thumb drive), I get the
following errors

/ #  usb 1-2: new high speed USB device using fsl-usb2-mph and address 8
usb 1-2: khubd timed out on ep0in
usb 1-2: new high speed USB device using fsl-usb2-mph and address 9
usb 1-2: khubd timed out on ep0in

It does not show up in /proc/bus/usb/devices (I do have usbfs mounted).

I also have usb-utils installed and lsusb fails to list the device.

I have also tried other USB devices and get similar errors.

Has anybody else experience similar problems? Any pointers/help will be
appreciated.

Thanks,
Prashant
