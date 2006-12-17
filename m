Return-Path: <pochini@shiny.it>
Received: from smtp-out13.alice.it (smtp-out13.alice.it [85.33.2.18])
	by ozlabs.org (Postfix) with ESMTP id 52F1567C1A
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 00:53:14 +1100 (EST)
Date: Sun, 17 Dec 2006 14:41:27 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@ozlabs.org
Subject: 2 CPUs, but only one is used
Message-Id: <20061217144127.579f01f0.pochini@shiny.it>
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

I have a dual G4 MDD mac running linux 2.6.19. When I boot with maxcpus=1 and
then I issue "echo 1 >/sys/devices/system/cpu/cpu1/online" the second CPU is
put online without errors, but it stays idle+wait=100% and of course
user+system+nice=0%. It works fine without maxcpus=1. No problems with 2.6.18.

I saw that there are some cpu hotplug related changes in 2.6.19, but I have
no access to a non-ppc dual cpu box to check if the problem also affects
other architectures right now.


--
Giuliano.
