Return-Path: <rocky.mussadi@tropos.com>
Received: from iceblock01.tropos.com (iceblock01.troposnetworks.com
	[12.108.168.187]) by ozlabs.org (Postfix) with SMTP id 7C93467A62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 11:16:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Yosemite board w/ppc440ep NETDEV WATCHDOG: eth0: transmit timed out
Date: Wed, 28 Jun 2006 18:10:28 -0700
Message-ID: <FF22D8DA3CC478438280A45A7CFAD27A012310A0@ca-bay-exch-01.tropos.com>
From: "Rocky Mussadi" <rocky.mussadi@tropos.com>
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

We are on the Yosemite reference board with IBM PPC440EP ver 2.0. On
this board, if we pass traffic from eth0 to eth1 and back, we run into
an eth0 and eth1 transmit lockup consistently. We use "nuttcp -T 2" to
generate the traffic. The interfaces are operating at 100/full
(autonegotiated). We have seen this with several different kernels up to
kernel 2.6.17.  When the lockup occurs we see the message:

    NETDEV WATCHDOG: eth0: transmit timed out

The only way to recover is via reboot.

Please note, we are running no software on the board except for the
kernel. This is the kernel that came with the reference board. The
driver being used is the ibm_emac driver.

Thanks for any help!
Rocky
