Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwZ3tywzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:06 +1000 (AEST)
In-Reply-To: <4c4cb05c4d.141a83d@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Olof Johansson <olof@lixom.net>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: powerpc/pasemi: Use pr_err/pr_warn... for kernel messages
Message-Id: <41ltwS5y51z9s8W@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-25 at 20:45:01 UTC, Darren Stevens wrote:
> Pasemi code still uses printk(KERN_ERR/KERN_WARN ... change these to
> pr_err(, pr_warn(... to match other powerpc arch code.
> 
> No functional changes.
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e13606d7321c0c08d4ac2d74a11026

cheers
