Return-Path: <psomas@cslab.ece.ntua.gr>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by ozlabs.org (Postfix) with ESMTP id D3E83B7136
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 May 2011 00:11:40 +1000 (EST)
From: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] ppc/cleaup: Fix compiler warnings
Date: Sat,  7 May 2011 17:11:29 +0300
Message-Id: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
Cc: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix compiler warnings in ppc code, which can lead to build failure, if
CONFIG_PPC_WERROR is set (default).

 arch/powerpc/include/asm/pgtable-ppc64.h |   13 ++++++-------
 arch/powerpc/kernel/Makefile             |    2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)
