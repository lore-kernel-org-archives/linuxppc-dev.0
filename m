Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (licentiaten.umea.hsb.se [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id 423A167A73
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Feb 2005 20:49:52 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id 051BF5C967C for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Feb 2005 10:49:49 +0100 (CET)
Received: from 220a.licentiaten.umea.hsb.se (220a.licentiaten.umea.hsb.se
	[212.32.155.230])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id E05555C9669 for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Feb 2005 10:49:47 +0100 (CET)
Date: Sun, 20 Feb 2005 10:49:50 +0100 (CET)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: linuxppc-embedded@ozlabs.org
Message-ID: <Pine.LNX.4.50.0502201034520.25626-100000@220a.licentiaten.umea.hsb.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Cross-compile kernel modules
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

I'm trying to get loadable kernel modules support on a Adder development board.
The kernel is cross-compiled on an regular PC and boots fine but I can't insert
any modules into the running kernel, all I get is undefined reference for all
functions called by the module. I use the kernel module utilities (insmod,
lsmod, modprobe) supplied by BusyBox to manage the modules on the Adder board.

What am I doning wrong? Do I need to perform any aditional steps when
cross-compiling kernel modules? My cross-compile toolchain have no depmod so I
have no modules.dep file. But I only need it if a module depend on other
modules, right?

/Markus

-----------------
Markus Westergren
Biologigrand 17
907 32 Umea
SWEDEN
