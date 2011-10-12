Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D656EB6F72
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:19:27 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl_msi: fix support for multiple MSI ranges
MIME-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1315948620-12402-1-git-send-email-timur@freescale.com>
Date: Tue, 11 Oct 2011 23:19:19 -0500
Message-ID: <1CC68F14-7A64-44DD-8141-095D7C883C14@freescale.com>
References: <1315948620-12402-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 13, 2011, at 4:17 PM, Timur Tabi wrote:

> Commit 6820fead ("powerpc/fsl_msi: Handle msi-available-ranges =
better") added
> support for multiple ranges in the msi-available-ranges property, but =
it
> miscalculated the MSIR index when multiple ranges are used.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_msi.c |    8 +++++---
> 1 files changed, 5 insertions(+), 3 deletions(-)

applied

- k=
