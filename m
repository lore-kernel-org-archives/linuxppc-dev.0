Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6A51B6EF1
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 02:58:04 +1100 (EST)
Received: from mail50-va3 (localhost [127.0.0.1])	by mail50-va3-R.bigfish.com
 (Postfix) with ESMTP id B9F473E0222	for <linuxppc-dev@ozlabs.org>;
 Thu, 16 Feb 2012 15:58:00 +0000 (UTC)
Received: from VA3EHSMHS002.bigfish.com (unknown [10.7.14.252])	by
 mail50-va3.bigfish.com (Postfix) with ESMTP id 184AB4C004B	for
 <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 15:57:59 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
Date: Thu, 16 Feb 2012 15:57:53 +0000
Message-ID: <CAOZdJXVo_UdD5U35_ro63_x=O8Ee_-SZ_3N_=-t_kwEEWbNVdg@mail.gmail.com>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <CAOZdJXX6sY4MxsqhjJZf26vrDxu6pxh2DtCqEERJ5JxbBFjEKA@mail.gmail.com>
In-Reply-To: <CAOZdJXX6sY4MxsqhjJZf26vrDxu6pxh2DtCqEERJ5JxbBFjEKA@mail.gmail.com>
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

On Thu, Feb 16, 2012 at 9:56 AM, Tabi Timur-B04825 <b04825@freescale.com> w=
rote:
> I think we should make 36-bit the only option for the upstream
> defconfigs, and if we want a 32-bit "optimized" kernel for the SDK,
> then we provide that on the SDK only.

Oops, I meant to post this as a reply to "powerpc/85xx: add a 36-bit
corenet default config".

--=20
Timur Tabi
Linux kernel developer at Freescale=
