Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1557A67B33
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 09:59:08 +1000 (EST)
Received: from localhost.localdomain ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k5NNx6s03305
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 04:59:06 +0500
Date: Sat, 24 Jun 2006 03:59:04 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/6] Add mpc8560 support to powerpc
Message-ID: <20060624035904.162b0276@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a first preliminary series to move 8560ads to powerpc and hence finish 
85xx family in terms of merge. Subsequient fs_enet patches are strictly required 
for the following to work, but submitted here as reference only 
(will be updated and sent to netdev shortly).

ATM not all points are adressed, there still may be bugs, but in general it works and have most
of the SoC stuff (UARTs, Gig eth, 100BaseT FCC) as well as the PCI stuff.

All the comments are greatly appreciated.

--
Sincerely, Vitaly
