Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t08t63FGnzDvWr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:34:22 +1100 (AEDT)
Date: Thu, 20 Oct 2016 14:55:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kernel: irq: fix build failure
In-Reply-To: <57FBBA0B.9070500@gmail.com>
Message-ID: <alpine.DEB.2.20.1610201454410.5073@nanos>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 10 Oct 2016, Sudip Mukherjee wrote:

> On Thursday 06 October 2016 11:06 PM, Sudip Mukherjee wrote:
> > The allmodconfig build of powerpc is failing with the error:
> > ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> > 
> > export the symbol to fix the failure.
> 
> Hi Thomas,
> powerpc and arm allmodconfig builds still fails with the same error.
> Build logs of next-20161010 are at:
> arm at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321467
> powerpc at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321473

I know. This is under discussion with the driver folks as we are not going
to blindly export stuff just because someone slapped a irq_set_parent()
into the code w/o knowing why.

Thanks,

	tglx
