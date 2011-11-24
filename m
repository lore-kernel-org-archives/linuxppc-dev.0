Return-Path: <B11780@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7DFDD1007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 18:12:54 +1100 (EST)
Received: from mail55-am1 (localhost [127.0.0.1])	by mail55-am1-R.bigfish.com
 (Postfix) with ESMTP id 51B946003F0	for <linuxppc-dev@ozlabs.org>;
 Thu, 24 Nov 2011 07:08:35 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.241])	by
 mail55-am1.bigfish.com (Postfix) with ESMTP id 37ACA700042	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 07:08:35 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: do not force PHYS_64BIT on the P1022DS
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1320349099-22594-1-git-send-email-timur@freescale.com>
Date: Thu, 24 Nov 2011 01:12:45 -0600
Message-ID: <C0BC3E1D-5FCF-42EC-A030-4F86EC1D76F3@freescale.com>
References: <1320349099-22594-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 3, 2011, at 2:38 PM, Timur Tabi wrote:

> Kconfig option PHYS_64BIT sets the size of phys_addr_t to 64 bits, =
which
> allows support for a 36-bit physical address space.  With this option, =
the
> kernel can support more than 2GB of RAM, but the larger address size
> impacts performance slightly.
>=20
> By including "select PHYS_64BIT" in the Kconfig for a particular =
board,
> that option is forced enabled, and it becomes impossible to create a =
32-bit
> kernel.  Instead, we should depend on the defconfig to enable this =
option.
> We still build a 36-bit kernel by default, and we also allow users to =
build
> 32-bit kernels if they really want.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)

If you want me to apply this please also provided a 32-bit .dts for =
p1022ds.  This should be pretty trivial based on my recent .dts =
cleanups.

- k=
