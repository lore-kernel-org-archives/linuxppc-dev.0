Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id E13E1DDEFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 01:20:36 +1000 (EST)
Subject: Virtex 4 Avnet Mini-Module Networking.
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF3C9BCACE.144FD16A-ON852572FF.004F2888-852572FF.005457E7@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Tue, 19 Jun 2007 11:21:15 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having trouble using the network on the Avent Mini-Module.  I had the
network working on the ML403 board with Linux 2.6.19.

The kernel comes up fine with the Mini-Module and the network seems to work
until I try to use it.  I can configured the ethernet with ifconfig and can
even ping another machine on the network.

The problem is with the TCP layer.  It seems almost everytime the
Mini-Module sends TCP information the checksum is reported an wrong (via
ethereal).  The only thing that comes to mind is the ML403 uses a Marvell
PHY and the Mini-Module has a Broadcom PHY.  I do not know enough about
low-level networking to know where the problem is.  Is the checksum
generated in the PHY?  Could something be wrong in Linux programming the
Broadcom PHY and not the Marvell PHY?  Why is it only the TCP information
(the IP information has the correct checksum)?

Thanks for any information you can offer.

Glenn
