Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1D809B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 07:38:48 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -mm 0/4] RapidIO: Misc updates
Date: Fri, 10 Dec 2010 15:38:14 -0500
Message-Id: <1292013498-31406-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following four patches are follow-up to two RapidIO patches
that are in the -mm tree now.

Alexandre Bounine (4):
  RapidIO: Add definitions of Component Tag fields
  RapidIO: Add device object linking into discovery
  RapidIO: Use Component Tag for unified switch identification
  RapidIO: Add new sysfs attributes

 drivers/rapidio/rio-scan.c  |   21 ++++++++++++---------
 drivers/rapidio/rio-sysfs.c |   39 ++++++++++++++++++++++++++++++++++++++-
 drivers/rapidio/rio.c       |    2 +-
 include/linux/rio.h         |   10 ++++++++++
 4 files changed, 61 insertions(+), 11 deletions(-)

-- 
1.7.3.1
