Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 262011A0E61
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 14:46:18 +1100 (AEDT)
Message-ID: <1449546377.12218.9.camel@ellerman.id.au>
Subject: Re: [PATCH v2 3/3] ppc64: Add a flag to tell the kernel it's
 booting from kexec
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>, Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 08 Dec 2015 14:46:17 +1100
In-Reply-To: <1449520948.15946.89.camel@freescale.com>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-3-git-send-email-scottwood@freescale.com>
 <1449520948.15946.89.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-12-07 at 14:42 -0600, Scott Wood wrote:
> On Tue, 2015-10-06 at 17:55 -0500, Scott Wood wrote:
> > It needs to know this because the SMP release mechanism for Freescale
> > book3e is different from when booting with normal hardware.  In theory
> > we could simulate the normal spin table mechanism, but not (easily) at
> > the addresses U-Boot put in the device tree -- so there'd need to be
> > even more communication between the kernel and kexec to set that up.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > v2: Use a device tree property rather than setting a flag in the kernel
> > image, as requested by Michael Ellerman.
> 
> ping?
> 
> Michael, can you review this?  Simon is waiting for another PPC person to
> review it.

Oh sorry I thought it'd been merged already, but I see now only 1 & 2 went in.

Horms this looks fine to me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
