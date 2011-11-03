Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AA22DB6F75
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 06:01:13 +1100 (EST)
Received: from mail40-db3 (localhost.localdomain [127.0.0.1])	by
 mail40-db3-R.bigfish.com (Postfix) with ESMTP id 5D53E1110540	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 19:01:02 +0000 (UTC)
Received: from DB3EHSMHS012.bigfish.com (unknown [10.3.81.247])	by
 mail40-db3.bigfish.com (Postfix) with ESMTP id 334871AB804B	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 19:01:02 +0000 (UTC)
Message-ID: <4EB2E4F0.8040108@freescale.com>
Date: Thu, 3 Nov 2011 14:01:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: do not force PHYS_64BIT on Freescale
 reference boards
References: <1320346215-21024-1-git-send-email-timur@freescale.com>
 <C957F668-1C3A-40CB-9505-27B4D6966751@freescale.com>
In-Reply-To: <C957F668-1C3A-40CB-9505-27B4D6966751@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Nak.  For certain boards like P204x-P50xx we only support a 36-bit address map.

I understand that we don't supply a 32-bit U-boot or device tree, but is
there any hard requirement that we force 36-bit kernels?  If it's really a
requirement, then adding to the Kconfig of each board doesn't sound like
the best way to enforce this.

-- 
Timur Tabi
Linux kernel developer at Freescale
