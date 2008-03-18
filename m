Return-Path: <olof@lixom.net>
Date: Mon, 17 Mar 2008 19:27:26 -0500
From: Olof Johansson <olof@lixom.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] pasemi_dma: Driver for PA Semi PWRficient on-chip
	DMA engine
Message-ID: <20080318002726.GA481@lixom.net>
References: <20080306233900.GA3969@lixom.net> <20080316213002.GA2589@lixom.net>
	<e9c3a7c20803171146m5a7f0e11m31e074634de22b42@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9c3a7c20803171146m5a7f0e11m31e074634de22b42@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, shannon.nelson@intel.com,
	linux-kernel@vger.kernel.org, hskinnemoen@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 11:46:39AM -0700, Dan Williams wrote:
> Looks good, makes me want to go back and cleanup iop-adma a bit.  A
> few fyi's below, but no other review comments.
> 
> >  Note that this still needs to go on top of the powerpc.git tree due to the
> >  pasemi_dma.h updates that this driver depends on. I suggest merging this
> >  through pasemi.git->powerpc.git->linus with an Acked-by from the DMA guys.
> 
> Ok, it still may not compile in mainline until after 2.6.26-rc1 due to
> additional dmaengine cleanups like the ack-to-flags change I posted
> earlier.  Any better way to handle this?  Go through -mm?

Either go through -mm where Andrew can keep it applied in appropriate
order and send upstream, or just merge it late. It's a new driver, and
they're normally OK to go in a little later. That might be the easiest
solution in this case.

> Acked-by: Dan Williams <dan.j.williams@intel.com>

Thanks!

-Olof
