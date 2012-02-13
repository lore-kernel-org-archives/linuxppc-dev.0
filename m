Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0DD6B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 03:40:32 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 2/2 v3] powerpc/dts: Add dts for p1025rdb board
Date: Mon, 13 Feb 2012 16:40:23 +0000
Message-ID: <CAOZdJXWjK6=0M78n9e93aSMMDXRORVVAeXqBnLyn835iv9i2yQ@mail.gmail.com>
References: <1328869096-23994-1-git-send-email-B32736@freescale.com>
 <1328869096-23994-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1328869096-23994-2-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 10, 2012 at 4:18 AM, Zhicheng Fan <B32736@freescale.com> wrote:
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-address =3D [ 00 =
00 00 00 00 00 ];

This doesn't belong in the DTS.

--=20
Timur Tabi
Linux kernel developer at Freescale=
