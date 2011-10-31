Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 57118B6F75
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 18:07:03 +1100 (EST)
Received: from mail134-tx2 (localhost.localdomain [127.0.0.1])	by
 mail134-tx2-R.bigfish.com (Postfix) with ESMTP id 70AEC16F00AB	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 07:06:53 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.247])	by
 mail134-tx2.bigfish.com (Postfix) with ESMTP id 5C6EE8A004B	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2011 07:06:53 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH SDK1.1 v2 0/2] PCIEP Patches Description
Date: Mon, 31 Oct 2011 13:54:50 +0800
Message-ID: <1320040492-6407-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches against kernel 3.0 for SDK 1.1.
The patches include contents from topic branch 15-pciep.
Also we add PCI related patch from topic branch 05-MPC8572DS here.
We update the pci/pcie initialization code.
