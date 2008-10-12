Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65FC7DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:08:23 +1100 (EST)
Received: id: bigeasy by Chamillionaire.breakpoint.cc authenticated by bigeasy
	with local (easymta 1.00 BETA 1) id 1Kp1cE-00022Z-M4
	for linuxppc-dev@ozlabs.org; Sun, 12 Oct 2008 16:08:14 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: Remove unused args in head_*
Date: Sun, 12 Oct 2008 16:08:12 +0200
Message-Id: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've stumbled over these while I tried to figure out how the boot procedure
is working on powerpc. Right now (in powerpc) the comment seems to reflect
the code but not what is actually happening: regs r4-r7 aren't used and r3
is the device tree.

Sebastian
