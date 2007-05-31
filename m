Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BA60DDFD8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 May 2007 20:06:55 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HthYR-0004lH-7p
	for linuxppc-embedded@ozlabs.org; Thu, 31 May 2007 03:06:51 -0700
Message-ID: <10890962.post@talk.nabble.com>
Date: Thu, 31 May 2007 03:06:51 -0700 (PDT)
From: Guillaume Berthelom <guillaume.berthelom@cleode.fr>
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx ethernet EMAC and bad checksum?
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


Hi,

I am trying to use the Xilinx ethernet EMAC drivers on my board with a
2.6.20 linux kernel.
I have used the adapter.c file from the EDK 8.2 and changed some functions
to adapte it for the 2.6 kernel, on the same way like Grant Likely did in
his TEMAC patch.

The ping and DHCP client work fine as same as the TCP handshake, so the
connexion is established fine. But when the frame (TCP or UDP) send by my
board need a checksum, this checksum failed and the server don't respond me.

I'm using the plb_ethernet IP in FIFO mode.

So if you could give me some way where might be the issue, I'll really
appreciate...
Thanks,
Guillaume Berthelom
-- 
View this message in context: http://www.nabble.com/Xilinx-ethernet-EMAC-and-bad-checksum--tf3845670.html#a10890962
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
