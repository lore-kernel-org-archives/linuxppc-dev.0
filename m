Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50F6EB7008
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 02:58:42 +1100 (EST)
Received: from mail152-tx2 (localhost [127.0.0.1])	by
 mail152-tx2-R.bigfish.com (Postfix) with ESMTP id A49D52A053F	for
 <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 15:56:52 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.240])	by
 mail152-tx2.bigfish.com (Postfix) with ESMTP id E73633A0045	for
 <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 15:56:50 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
Date: Thu, 16 Feb 2012 15:56:48 +0000
Message-ID: <CAOZdJXX6sY4MxsqhjJZf26vrDxu6pxh2DtCqEERJ5JxbBFjEKA@mail.gmail.com>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
In-Reply-To: <1329394210-1014-1-git-send-email-leoli@freescale.com>
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

On Thu, Feb 16, 2012 at 6:10 AM, Li Yang <leoli@freescale.com> wrote:
>
> The reason why we need to keep PHYS_64BIT option configurable is
> that enabling it cause negative performance impact on various
> aspects like TLB miss and physical address manipulating. =A0We should
> not enable it unless really needed, e.g. use large memory of 4GB
> or bigger.

I think we should make 36-bit the only option for the upstream
defconfigs, and if we want a 32-bit "optimized" kernel for the SDK,
then we provide that on the SDK only.

--=20
Timur Tabi
Linux kernel developer at Freescale=
