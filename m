Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 4C936DE074
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:34:05 +1000 (EST)
Date: Mon, 18 May 2009 19:33:52 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090518173352.GA11767@iram.es>
References: <20090515181813.GA28132@iram.es>
	<1242617089.18075.25.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1242617089.18075.25.camel@pasglop>
Cc: LinuxPPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 18, 2009 at 01:24:49PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2009-05-15 at 20:18 +0200, Gabriel Paubert wrote:
> > Since PPC_MUTIPLATFORM was removed, it was impossible to select the
> > driver for mv643xx_eth on the Pegasos. Fix by allowing to select
> > the driver on CHRP platforms; Pegasos is a CHRP platform and the driver
> > will not work wihtout arch/powerpc/platforms/chrp/pegasos_eth.
> > 
> > The patch also removes all references to MV64360 config option which 
> > no more exists.
> > 
> > Signed-off-by: Gabriel Paubert <paubert@iram.es> 
> 
> Please break that up into 2 different patches. The arch/powerpc one that
> removes the reference from IRQ_ALL_CPUs and the drivers/net/ one which
> should be set to the netdev mailing list.
> 

Ok, but I have a doubt about the PPC one, should MV64360 be removed or
changed to MV64X60?

In any case, I can't test it.

	Gabriel
