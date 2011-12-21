Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C3A72B70F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 18:58:26 +1100 (EST)
Received: from mail125-tx2 (localhost [127.0.0.1])	by
 mail125-tx2-R.bigfish.com (Postfix) with ESMTP id 4D2CF180410	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:49 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.236])	by
 mail125-tx2.bigfish.com (Postfix) with ESMTP id 2B3FA480043	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:49 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH SDK1.2 0/3] pci patches description
Date: Wed, 21 Dec 2011 15:10:55 +0800
Message-ID: <1324451458-4644-1-git-send-email-B38951@freescale.com>
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

This serials of patches include two parts.
First, we unify the pci initialization code using platform driver
mechanism. Then, we add PM support for deep sleep stat to save and
restore inbound/outbound window registers.

These patches are against 'next' branch on:
http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git
