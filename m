Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA32FB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 03:08:41 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 2/2 v4] powerpc/dts: Add dts for p1020rdb-pc board
Date: Thu, 9 Feb 2012 16:08:27 +0000
Message-ID: <CAOZdJXVkGJmokD6176uoW7G0UHxA9H_=-MUL1_YxgR6aNJ8dmQ@mail.gmail.com>
References: <1328766036-17697-1-git-send-email-B32736@freescale.com>
 <1328766036-17697-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1328766036-17697-2-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 8, 2012 at 11:40 PM, Zhicheng Fan <B32736@freescale.com> wrote:
>
> =A0arch/powerpc/boot/dts/p1020rdb-pc.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 90 =
++++++++
> =A0arch/powerpc/boot/dts/p1020rdb-pc.dtsi =A0 =A0 =A0 =A0 =A0 | =A0247 ++=
++++++++++++++++++++
> =A0arch/powerpc/boot/dts/p1020rdb-pc_36b.dts =A0 =A0 =A0 =A0| =A0 90 ++++=
++++

If we're going to support both 32-bit and 36-bit dts files, then we
have to label both DTS files properly.  Do not assume that 32-bit is
the "default", because on some platforms, 36-bit is the default.

p1020rdb-pc.dts should be called p1020rdb-pc_32b.dts.

--=20
Timur Tabi
Linux kernel developer at Freescale=
