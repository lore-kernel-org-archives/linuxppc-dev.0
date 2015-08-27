Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD19F1A1E1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 11:14:21 +1000 (AEST)
Message-ID: <1440638061.23182.8.camel@ellerman.id.au>
Subject: Re: Pull request: scottwood/linux.git next
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Aug 2015 11:14:21 +1000
In-Reply-To: <1440598476.16577.107.camel@freescale.com>
References: <20150818043004.GA29954@home.buserror.net>
 <1440598476.16577.107.camel@freescale.com>
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

On Wed, 2015-08-26 at 09:14 -0500, Scott Wood wrote:
> On Mon, 2015-08-17 at 23:30 -0500, Scott Wood wrote:
> > Highlights include 32-bit memcpy/memset optimizations, checksum
> > optimizations, 85xx config fragments and updates, device tree updates,
> > e6500 fixes for non-SMP, and misc cleanup and minor fixes.
> > 
> > The following changes since commit 79cd95200035fb4b39b089dd01c13302eee6ee03:
> > 
> >   powerpc/eeh: Dump PHB diag-data for non-existing PE (2015-07-21 11:38:47 
> > +1000)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> > 
> > for you to fetch changes up to 4524cd093fa8f03b198e095ebbb679c30839559c:
> > 
> >   powerpc/t1023rdb/dts: set ifc nand chip select from 2 to 1 (2015-08-17 
> > 19:41:16 -0500)
> 
> ping

Yeah sorry, I did see it, I was just waiting to see if we were getting an rc8.

I'll pull it in today and then do the defconfig update on top of it.

cheer
