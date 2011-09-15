Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50AC4B70FE
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 07:39:06 +1000 (EST)
Message-ID: <4E727072.7050401@freescale.com>
Date: Thu, 15 Sep 2011 16:38:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_msi: fix support for multiple MSI ranges
References: <1315948620-12402-1-git-send-email-timur@freescale.com>
In-Reply-To: <1315948620-12402-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: kumar.gala@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/13/2011 04:17 PM, Timur Tabi wrote:
> Commit 6820fead ("powerpc/fsl_msi: Handle msi-available-ranges better") added
> support for multiple ranges in the msi-available-ranges property, but it
> miscalculated the MSIR index when multiple ranges are used.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_msi.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
