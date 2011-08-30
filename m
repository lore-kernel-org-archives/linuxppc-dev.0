Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44FB9B6F86
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 08:25:05 +1000 (EST)
Received: from mail139-tx2 (localhost.localdomain [127.0.0.1])	by
	mail139-tx2-R.bigfish.com (Postfix) with ESMTP id EAF30D4057C	for
	<linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 22:25:02 +0000 (UTC)
Received: from TX2EHSMHS024.bigfish.com (unknown [10.9.14.250])	by
	mail139-tx2.bigfish.com (Postfix) with ESMTP id 98F3C1C2804C	for
	<linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 22:25:02 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_msi: clean up and document calculation of
	MSIIR address
Date: Tue, 30 Aug 2011 22:24:59 +0000
Message-ID: <4E5D633B.6090500@freescale.com>
References: <1314404912-6947-1-git-send-email-timur@freescale.com>
In-Reply-To: <1314404912-6947-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Commit 3da34aae (powerpc/fsl: Support unique MSI addresses per PCIe Root
> Complex) redefined the meanings of msi->msi_addr_hi and msi->msi_addr_lo =
to be
> an offset rather than an address.  To help clarify the code, we make the
> following changes:

Kumar, I'm going to merge this patch into a bigger patch that makes a=20
bunch of other fixes.=
