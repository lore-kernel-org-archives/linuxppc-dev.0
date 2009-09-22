Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E33D4B7043
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 01:23:55 +1000 (EST)
From: Tim Abbott <tabbott@ksplice.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] Linker script cleanup for powerpc
Date: Tue, 22 Sep 2009 11:18:08 -0400
Message-Id: <1253632689-24173-1-git-send-email-tabbott@ksplice.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an updated version of the patch I sent on September 6 cleaning
up the powerpc architecture's linker scripts.  The only change is that
it is rebased on top of Linus's current master.

This cross-architecture linker script cleanup project is in
preparation for adding support for building the kernel with
-ffunction-sections -fdata-sections, which is a prerequisite for
Ksplice.

	-Tim Abbott

Tim Abbott (1):
  powerpc: Cleanup linker script using new linker script macros.

 arch/powerpc/kernel/vmlinux.lds.S |   69 ++++++++-----------------------------
 1 files changed, 15 insertions(+), 54 deletions(-)
