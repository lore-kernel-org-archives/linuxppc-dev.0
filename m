Return-Path: <edjubenville@adelphia.net>
Received: from mta9.adelphia.net (mta9.adelphia.net [68.168.78.199])
	by ozlabs.org (Postfix) with ESMTP id 92B26679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 16:01:09 +1100 (EST)
Received: from EJ1 ([70.37.70.76]) by mta11.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20060314044054.EQQK17101.mta11.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Mar 2006 23:40:54 -0500
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Where to define IO ports
Date: Mon, 13 Mar 2006 20:40:54 -0800
Message-ID: <GPECLCIGPLHEOMGPMCPAGELLDIAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are building a board similar to the Freescale Lite5200 (IceCube) board,
using ELDK 3.0 with Linux 2.4.25.

We have added a peripheral to the LocalPlus bus, and I'm trying to figure
out how to modify the kernel startup code to define a memory address range
and generate the proper chip select signal.

Can someone point me to where that sort of thing is done in the kernel
source?

Ed
