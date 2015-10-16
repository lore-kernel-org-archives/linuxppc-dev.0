Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 4F3F41A0762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 12:54:51 +1100 (AEDT)
Date: Fri, 16 Oct 2015 10:48:38 +0900
From: Simon Horman <horms@verge.net.au>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 3/3] ppc64: Add a flag to tell the kernel it's booting
 from kexec
Message-ID: <20151016014838.GG20667@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-3-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444172150-29493-3-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2015 at 05:55:50PM -0500, Scott Wood wrote:
> It needs to know this because the SMP release mechanism for Freescale
> book3e is different from when booting with normal hardware.  In theory
> we could simulate the normal spin table mechanism, but not (easily) at
> the addresses U-Boot put in the device tree -- so there'd need to be
> even more communication between the kernel and kexec to set that up.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: Use a device tree property rather than setting a flag in the kernel
> image, as requested by Michael Ellerman.

I'd value a review of this from someone more familiar with ppc than I.
