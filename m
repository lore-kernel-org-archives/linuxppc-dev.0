Return-Path: <pochini@shiny.it>
Received: from out2.alice.it (smtp-out03.alice.it [85.37.17.99])
	by ozlabs.org (Postfix) with ESMTP id 634A467B1D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 08:11:32 +1000 (EST)
Date: Tue, 23 May 2006 23:58:19 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: CPU 1 refused to die!
Message-Id: <20060523235819.473e4149.pochini@shiny.it>
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


I booted with maxcpus=1, then I enabled the 2nd cpu
with echo 1 > /sys/devices/system/cpu/cpu1/online

I can't disable it anymore. dmesg says "CPU 1 refused to die!".
/proc/cpuinfo and /proc/interrupts show one cpu only and the tasks run on
one cpu after the echo 0 > /sys/... , but since the command takes a couple
of seconds to complete I think it's not simply a bogus error message.

Dual G4 MDD
Linux Jay 2.6.16.16 #8 SMP Sat May 13 19:15:05 CEST 2006 ppc 7455,
altivec supported PowerMac3,6 GNU/Linux

--
Giuliano.
