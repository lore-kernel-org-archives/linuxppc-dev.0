Return-Path: <xiay@nari-relays.com>
Received: from NARI-RELAYS.COM (unknown [221.226.124.170])
	by ozlabs.org (Postfix) with ESMTP id DCDF668415
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 13:44:28 +1000 (EST)
Date: Thu, 29 Sep 2005 11:56:32 +0800
Message-Id: <200509291156.AA2359564@NARI-RELAYS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "=?ISO-8859-1?Q?=CF=C4=D3=EA?= " <xiay@nari-relays.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: how to make a PCI net card work on ICECUBE ?
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

Thanks for your help.

I found out that the ICECUBE board could tftpboot via the PCI netcard if wire net to the card, but the board could not mount NFS via the card.

So i set the environment ethact to i82559#0 and saveenv , but the board still could not mount NFS via the card.During the booting-up ,there was nothing about eth1 shown .

And i wired net to the FEC ethernet port,reset the board,found that the environment ethact was now FEC ETHERNET,so i set it again to i82559#0 and saveenv,booted up the kernel, there was nothing about eth1 shown , i tried ifconfig eth1 * up ,information were below: 

bash-2.05b# ifconfig eth1 198.87.102.218 up
SIOCSIFADDR: No such device
eth1: unknown interface: No such device
eth1: unknown interface: No such device 

where did i make mistakes ?

Best Regards

xiayu 
