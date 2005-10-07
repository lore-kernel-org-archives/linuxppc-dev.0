Return-Path: <xiay@nari-relays.com>
Received: from NARI-RELAYS.COM (unknown [221.226.124.170])
	by ozlabs.org (Postfix) with ESMTP id 5F9BE684CA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 19:59:50 +1000 (EST)
Date: Fri,  7 Oct 2005 18:10:58 +0800
Message-Id: <200510071810.AA52953120@NARI-RELAYS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "=?ISO-8859-1?Q?=CF=C4=D3=EA?= " <xiay@nari-relays.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: deboralh@sinovee.com
Subject: about pci net controller without EPROM onboard
Reply-To: xiay@nari-relays.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the help , i found out that the kernel was not configued well for pci net card .

Now i am boarding U-BOOT and kernel(linuxppc) to my own board (based on MPC5200,have a i82551 on board without 

EPROM).After i set the eth1addr ,U-boot could tftp files through the i82551 chip :

PCI:   Bus Dev VenId DevId Class Int
        00  18  8086  1209  0200  00
        00  1a  1057  5803  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET, i82559#0

But after the kernel bootup ,i could not find eth1 ,message during bootup as follow :

POSIX conformance testing by UNIFIX

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:1a.0

Intel(R) PRO/100 Network Driver - version 2.3.38-k1
Copyright (c) 2004 Intel Corporation
PCI: Enabling device 00:18.0 (0006 -> 0007)
e100: Invalid Ethernet address
e100: Failed to initialize, instance #0

How can i make the chip active ?
