Return-Path: <pochini@shiny.it>
Received: from vsmtp21alice.tin.it (vsmtp21.tin.it [212.216.176.109])
	by ozlabs.org (Postfix) with ESMTP id 3CC2D687C7
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2005 22:43:56 +1100 (EST)
Received: from Jay (82.50.58.1) by vsmtp21alice.tin.it (7.2.060.1)
	id 437B155F00155FF7 for linuxppc-dev@ozlabs.org;
	Sat, 26 Nov 2005 12:38:20 +0100
Date: Sat, 26 Nov 2005 11:38:05 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Message-Id: <20051126113805.709ee538.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: CPU off power consumption
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Out of curiosity, what's the difference between a cpu that has never been
enabled and one that has been disabled with echo 0>/sys/.../online ? It
happens that when I boot with maxcpus=0 the temperature always stays low
enoung that the fan never spins up. If I enable and then I immediately
disable the 2nd cpu, the temperature goes a few degrees up. I have a dual
G4-MDD.

--
Giuliano.
