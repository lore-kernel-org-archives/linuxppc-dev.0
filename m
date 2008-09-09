Return-Path: <neerajg@cdac.in>
Received: from mx2.cdac.in (mx2.cdac.in [203.199.132.25])
	by ozlabs.org (Postfix) with ESMTP id 8D8C4DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 16:14:06 +1000 (EST)
Received: from mailhub.cdac.in (mailhub [196.1.109.254])by mailhub.cdac.in
	(8.13.4/8.13.4) with ESMTP id m8949JY7019721for
	<linuxppc-embedded@ozlabs.org>; Tue, 9 Sep 2008 09:39:19 +0530
Message-ID: <48C5F6ED.4000804@cdac.in>
Date: Tue, 09 Sep 2008 09:39:17 +0530
From: Neeraj Garg <neerajg@cdac.in>
MIME-Version: 1.0
To: schardt@team-ctech.de
Subject: RE: EDK10.1 and emaclite
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Georg,

Can you post linux bootup message where its says PHY is detected at 
paticular address, and check with your hardware what is actual address 
of PHY. Also I would like to know the configuration of your hardware 
whether its configured of 10MBPS OR 100MBPS.


------------------------------------------------------------------------------------------
--
Neeraj Garg



Message: 3
Date: Mon, 08 Sep 2008 18:29:53 +0200
From: Georg Schardt <schardt@team-ctech.de>
Subject: EDK10.1 and emaclite
To: linuxppc-embedded@ozlabs.org
Message-ID: <48C55301.4070208@team-ctech.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hi all,

im trying to use the emaclite core which comes with the EDK10.1 with the 
2.6.26 kernel from git.xilinx.com on virtex4fx12 minimodul. the emac is 
detect by the kernel:

xilinx_emaclite xilinx_emaclite.0: MAC address is now  2: 0: 0: 0: 0: 0
xilinx_emaclite xilinx_emaclite.0: using fifo mode.
xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at 0x81000000 mapped 
to 0xC5060000, irq=0

i can change the mac-address with ifconfig and i can give an ip-address 
to the device,
but a ping is not possible and arp is not working. i think that the phy 
is not working right.

has someone others the same problem ? what can i changed ? i have tried 
out all possible phy driver in the linux  kernel

a setup with the lltemac is working fine, but i want to use the emaclite

thanks
regards
georg
