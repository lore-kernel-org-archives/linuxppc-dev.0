Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F241B1007E8
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 04:11:18 +1100 (EST)
From: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Kexec support for FSL-BookE, take two
Date: Fri, 15 Jan 2010 17:41:32 +0100
Message-Id: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is take two :)
SMP support did not work in the first one and due to the lack of a working
SMP machine it is still absent. I took the e500v1 problem into account and
the result is that I now use multiple 256MiB mappings.
The final mapping covers the first 2GiB so the part of the highmem should
be also covered and not just kernel memory.

The first three patches prepare the entry code to work outside of the
first page. Patch 4 simply moves code and finally patch 5 implements the
kexec functionality.


Sebastian
