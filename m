Return-Path: <olof@lixom.net>
Date: Thu, 6 Mar 2008 19:35:48 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pasemi_dma: Driver for PA Semi PWRficient on-chip DMA
	engine
Message-ID: <20080307013548.GA4965@lixom.net>
References: <20080306233900.GA3969@lixom.net>
	<20080307113150.c0874344.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080307113150.c0874344.sfr@canb.auug.org.au>
Cc: hskinnemoen@atmel.com, shannon.nelson@intel.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	pasemi-linux@ozlabs.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 11:31:50AM +1100, Stephen Rothwell wrote:
> Hi Olof,
> 
> Just one thing I noticed ...
> 
> On Thu, 6 Mar 2008 17:39:00 -0600 Olof Johansson <olof@lixom.net> wrote:
> >
> > +	dma_dev->device_dependency_added = pasemi_dma_dependency_added;
> 
> device_dependency_added is going away in 2.6.26 ...

Thanks, I guess I need to base this on top of both powerpc and the
async-tx git trees and just merge it late.


-Olof
