Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FC80B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 07:04:53 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/mpc85xx: p1022ds support the MTD for NOR
 and NAND flash
Date: Thu, 10 May 2012 21:04:44 +0000
Message-ID: <CAOZdJXUU570dAxiR4u2twJkaPH9yVvsAvFDRTNnLN95F-_3Uew@mail.gmail.com>
References: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
In-Reply-To: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
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

On Mon, Apr 16, 2012 at 8:42 PM,  <Chang-Ming.Huang@freescale.com> wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> The compatilbe 'simple-bus' is removed from the latest DTS for NAND and
> NOR flash partition, so we must add the new compatilbe support for p1022d=
s,
> otherwise, the kernel can't parse the partition of NOR and NAND flash.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---

This patch is no longer compatible with the upstream kernel since my
patch, "powerpc/85xx: don't call of_platform_bus_probe() twice" was
applied.  This is because my patch removed p1022_ds_ids[].

--=20
Timur Tabi
Linux kernel developer at Freescale=
