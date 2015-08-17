Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 916E21A0501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 05:00:18 +1000 (AEST)
Message-ID: <1439837987.15601.29.camel@freescale.com>
Subject: Re: [PATCH 2/2] ppc64: Add a flag to tell the kernel it's booting
 from kexec
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <kexec@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 17 Aug 2015 13:59:47 -0500
In-Reply-To: <1437249439-31496-2-git-send-email-scottwood@freescale.com>
References: <1437249439-31496-1-git-send-email-scottwood@freescale.com>
 <1437249439-31496-2-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-07-18 at 14:57 -0500, Scott Wood wrote:
> It needs to know this because the SMP release mechanism for Freescale
> book3e is different from when booting with normal hardware.  In theory
> we could simulate the normal spin table mechanism, but not (easily) at
> the addresses U-Boot put in the device tree -- so there'd need to be
> even more communication between the kernel and kexec to set that up.
> Since there's already a similar flag being set (for kdump only), this
> seemed like a reasonable approach.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  kexec/arch/ppc64/kexec-elf-ppc64.c | 11 ++++++++++-
>  kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
>  purgatory/arch/ppc64/v2wrap.S      | 11 +++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)

Any comment on these two patches?

-Scott
