Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6031DE509
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 07:20:43 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] kexec support on Book-e, ppc32
Date: Wed,  1 Oct 2008 23:20:21 +0200
Message-Id: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
Cc: kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is what I am currently using for kexec support on mpc8544 / Book-E.
The userland (patch #3) behaves similar to the ppc64 code. Purgatory is
available and the user can specify new device tree. In v2wrap.S the setup
of the stack is disabled. I'm not sure why but as soon as I enable it,
the kernel does not appear. I think that I'm loading the value from the
wrong address but the same code is working for the kernel entry point.

Patch #1 adds support for the kernel. I've extended the misc32 code
because I did not want to copy the move_page_code.

Patch #2 adds the required callbacks to platform code of 8544ds

Sebastian
