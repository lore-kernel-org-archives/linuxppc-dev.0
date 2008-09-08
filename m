Return-Path: <schardt@team-ctech.de>
Received: from www2.team-ctech.de (www2.team-ctech.de [62.146.20.117])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDFC6DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 03:20:28 +1000 (EST)
Received: from static-87-79-236-23.netcologne.de ([87.79.236.23]
	helo=[192.168.6.21]) by www2.team-ctech.de with esmtpa (Exim 4.69)
	(envelope-from <schardt@team-ctech.de>) id 1Kcjce-0003ke-FI
	for linuxppc-embedded@ozlabs.org; Mon, 08 Sep 2008 18:29:52 +0200
Message-ID: <48C55301.4070208@team-ctech.de>
Date: Mon, 08 Sep 2008 18:29:53 +0200
From: Georg Schardt <schardt@team-ctech.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: EDK10.1 and emaclite
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
