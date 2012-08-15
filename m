Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C2D0D2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 19:25:22 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <benh@kernel.crashing.org>
Subject: [PATCH V7 0/3] PCI unification patch description
Date: Wed, 15 Aug 2012 16:57:03 +0800
Message-ID: <1345021026-10886-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

In this patch set we unified the Freescale pci/pcie initialization by
changing the fsl_pci to a platform driver. 

We also change the way of determining primary bus for fitting platform
driver. The first two patches are the preparation for this.

Thanks to Ben. For the first patch you can refer to the following link:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html
