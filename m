Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai08.cox.net (fed1rmmtai08.cox.net [68.230.241.51])
	by ozlabs.org (Postfix) with ESMTP id DE08D67A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 04:20:52 +1000 (EST)
Date: Mon, 15 May 2006 10:16:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brent Cook <bcook@bpointsys.com>
Subject: Re: [PATCH] Export PowerPC atomic operations to userspace
Message-ID: <20060515171629.GC22868@smtp.west.cox.net>
References: <200605151154.52599.bcook@bpointsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200605151154.52599.bcook@bpointsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 15, 2006 at 11:54:52AM -0500, Brent Cook wrote:

> The atomic operations in asm/atomic.h are really useful from userspace too. 
> Other architectures (i386, x86_64, mips) export these to userspace, but the 
> powerpc versions are guarded by __KERNEL__ for some reason. Can we remove 
> these if there is no good reason to guard them?
> 
> Signed-off-by: Brent Cook <bcook@bpointsys.com>

NAK.  i386, x86_64 and mips are broken in this regard.  Please google up
the previous threads that explain why you can't always get atomic
operations on all architectures and why exporting this is bad.

-- 
Tom Rini
