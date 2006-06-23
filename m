Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-41-194.msk.skylink.ru
	[83.217.41.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E482467A70
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 09:46:35 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k5NNGmGR006724
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 03:16:53 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/6] Add mpc8560 support to powerpc 
Date: Fri, 23 Jun 2006 23:12:34 +0400
Message-Id: <20060623191234.14374.13540.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a first preliminary series to move 8560ads to powerpc and hence finish 
85xx family in terms of merge. Subsequient fs_enet/PAL patches are required 
for the following to work, but submitted here as reference only 
(will be updated and sent to netdev shortly).

ATM not all points are adressed, there still may be bugs, but in general it works.
Most of the SoC stuff (UARTs, Gig eth, 100BaseT FCC) as well as the PCI stuff are
functional.

All the comments are greatly appreciated.
--
Sincerely, Vitaly
