Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 336922BDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 14:13:57 +1100 (EST)
Date: Thu, 25 Nov 2004 10:42:34 +0800
Message-Id: <200411251042.AA26804430@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-dev@ozlabs.org>
Subject: problem on netdevice
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
    Please tell me how can I handle it! Thanks in advance!
Best Regards
zhonglei
