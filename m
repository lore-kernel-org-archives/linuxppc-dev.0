Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 6B30B2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Nov 2004 14:13:56 +1100 (EST)
Date: Thu, 25 Nov 2004 10:37:56 +0800
Message-Id: <200411251037.AA26149070@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-embedded@ozlabs.org>
Subject: question on netdevice
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi
   Sorry for bothering you! But would you please give me a hand.When I insert a Intel Pro/100s server Adapter into the PCI slot on Lite5200(motorola MPC5200 development kit) and start the embedded kernel,the kernel run into a dead lock. (Before that I used 'make xconfig' to enable the e100 driver in kernel)
The reports are as follows:
.
.
.
IP-Config: Retrying forever (NFS root)...
eth1: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
eth1: Waiting for the link to be up...
eth1: status: link up, 100 Mbps Full Duplex, auto-negotiation complete.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Sending DHCP requests ...... timed out!
    Because there is another netdevice in MPC5200(I use it to mount NFS root) as eth0 , is there a ip setting problem? 
    Please tell me how can I handle it! Thanks in advance!
Best Regards
zhonglei
