Return-Path: <albert_herranz@yahoo.es>
Received: from smtp120.mail.ukl.yahoo.com (smtp120.mail.ukl.yahoo.com
	[77.238.184.51]) by ozlabs.org (Postfix) with SMTP id 99A00B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 07:35:10 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v4 0/2] rework of usbgecko-based early debug
Date: Thu,  3 Dec 2009 21:34:58 +0100
Message-Id: <cover.1259871725.git.albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is v4 of the "early debugging using usbgecko" patch.

It tries to implement the ideas suggested by Benjamin Herrenschmidt
regarding the use of a set of fixmap entries to provide safe
virtual address space for an early mapping.

Albert Herranz (2):
  powerpc: reserve fixmap entries for early debug
  powerpc: gamecube/wii: early debugging using usbgecko

 arch/powerpc/Kconfig.debug                         |    8 +++
 arch/powerpc/include/asm/fixmap.h                  |    3 +
 arch/powerpc/include/asm/udbg.h                    |    1 +
 arch/powerpc/kernel/head_32.S                      |   25 +++++++++
 arch/powerpc/kernel/udbg.c                         |    2 +
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   56 ++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    2 +
 7 files changed, 97 insertions(+), 0 deletions(-)
