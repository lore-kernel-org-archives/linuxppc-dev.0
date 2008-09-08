Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 5C247DE0D4
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Sep 2008 23:04:56 +1000 (EST)
Received: by gxk14 with SMTP id 14so7559190gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Sep 2008 06:04:54 -0700 (PDT)
Message-Id: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Mon, 8 Sep 2008 08:44:59 -0400
Subject: [PATCH 0/3 v2] ibm_newemac: Various fixes and additions for PPC405EZ
To: benh@kernel.crashing.org, netdev@vger.kernel.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch series adds things needed to support the PowerPC 405EZ
SoC.  I've incorporated the suggestions and fixes from the previous round
of patches and barring any further comments these should be ready to go.

josh

Josh Boyer (3):
  ibm_newemac: Allow the "no flow control" EMAC feature to work
  ibm_newemac: Introduce mal_has_feature
  ibm_newemac: MAL support for PowerPC 405EZ

 arch/powerpc/include/asm/dcr-regs.h |    7 ++++
 drivers/net/ibm_newemac/Kconfig     |   12 +++++++
 drivers/net/ibm_newemac/core.c      |    2 +
 drivers/net/ibm_newemac/core.h      |    3 ++
 drivers/net/ibm_newemac/mal.c       |   60 ++++++++++++++++++++++++++++++++---
 drivers/net/ibm_newemac/mal.h       |   34 ++++++++++++++++++++
 6 files changed, 113 insertions(+), 5 deletions(-)
