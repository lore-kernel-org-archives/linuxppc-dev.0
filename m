Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFFDFB6FC2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 20:00:24 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 0/6] Description for PCI patches using platform driver
Date: Fri, 8 Jun 2012 17:42:01 +0800
Message-ID: <1339148527-16911-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: R65777@freescale.com, b38951@freescale.com, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches are to unify pci initialization code and add PM support
for all 85xx/86xx powerpc boards. But two side effects are introduced by this
mechanism which listed below:

1. of_platform_bus_probe() will be called twice but in some cases duplication
   warning occured. We fix this in [PATCH 5/6].

2. Edac driver failed to register pci nodes as platform devices. We fix this
   in [PATCH 6/6].

These patches are against 'next' branch on:
http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git
