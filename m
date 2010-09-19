Return-Path: <pochini@shiny.it>
Received: from smtp204.alice.it (smtp204.alice.it [82.57.200.100])
	by ozlabs.org (Postfix) with ESMTP id 3E554B6EF1
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 07:37:07 +1000 (EST)
Received: from Jay (80.183.22.57) by smtp204.alice.it (8.5.124.08)
	id 4C88E33B00D0F7C7 for linuxppc-dev@ozlabs.org;
	Sun, 19 Sep 2010 23:31:50 +0200
Date: Sun, 19 Sep 2010 23:31:50 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: CPU 1 refused to die! (pmac dual G4 MDD)
Message-ID: <20100919233150.4b0155df@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When I do:

echo 0 >/sys/devices/system/cpu/cpu1/online

it waits for a few seconds and dmesg reports:

CPU1 offline
CPU 1 refused to die!

The cpu is not online anymore and top does not list it. I can be re-enabled.
Everything looks ok, except that error message. It worked fine in 2.6.33.
I don't know if it's a ppc specific bug.

$ uname -a
Linux Jay 2.6.35.4 #3 SMP Sat Sep 18 20:03:06 CEST 2010 ppc 7455, altivec supported PowerMac3,6 GNU/Linux


-- 
Giuliano.
