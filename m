Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 85615B6F01
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 15:12:19 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 0/3] Misc. bug fixes for ppc32
Date: Wed, 18 Aug 2010 23:56:48 -0500
Message-ID: <1282193811-23098-1-git-send-email-msm@freescale.com>
In-Reply-To: <20100819042023.GC13965@verge.net.au>
References: <20100819042023.GC13965@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: muvarov@gmail.com, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series fixes a few issues I have discovered with my previous
patch series. Nothing new has been added.

v2: Missed signoff, removed initializing variable twice

Matthew McClintock (3):
  Ramdisk address was not copied correctly on kexec'ed kernel
  Prevent multiple reservations for cpu-release-addr
  Prevent initrd-start and initrd-end from appearing multiple times

 kexec/arch/ppc/fixup_dtb.c |   50 ++++++++++++++++++++++++-------------------
 kexec/arch/ppc/kexec-ppc.c |    2 +-
 2 files changed, 29 insertions(+), 23 deletions(-)
