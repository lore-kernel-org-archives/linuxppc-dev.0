Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7E5DD1007D7
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2011 00:57:04 +1100 (EST)
Received: from mail143-va3 (localhost [127.0.0.1])	by
 mail143-va3-R.bigfish.com (Postfix) with ESMTP id 616BF6002ED	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 13:58:36 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.244])	by
 mail143-va3.bigfish.com (Postfix) with ESMTP id 9DFC020282	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 13:58:07 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: do not force PHYS_64BIT on the P1022DS
Date: Thu, 24 Nov 2011 13:56:03 +0000
Message-ID: <B617107E-9D15-4DA9-996C-2A4671809AA0@freescale.com>
References: <1320349099-22594-1-git-send-email-timur@freescale.com>
 <C0BC3E1D-5FCF-42EC-A030-4F86EC1D76F3@freescale.com>
In-Reply-To: <C0BC3E1D-5FCF-42EC-A030-4F86EC1D76F3@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 24, 2011, at 1:12 AM, Kumar Gala <kumar.gala@freescale.com> wrote:

>=20
> If you want me to apply this please also provided a 32-bit .dts for p1022=
ds.  This should be pretty trivial based on my recent .dts cleanups.

Ok, I'll do that.=
