Return-Path: <mmporter@cox.net>
Date: Wed, 19 Jan 2005 07:56:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20050119075603.B448@home.com>
References: <66164fbc0501190353485dc8e4@mail.gmail.com>
	<20050119141048.GA13254@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050119141048.GA13254@lst.de>;
	from hch@lst.de on Wed, Jan 19, 2005 at 03:10:48PM +0100
Cc: Linuxppc-dev@ozlabs.org, Sachin P <sachinpc@gmail.com>
Subject: Re: consistent_alloc() on PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 19, 2005 at 03:10:48PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 19, 2005 at 05:23:17PM +0530, Sachin P wrote:
> > Hi , 
> > I am facing some problems porting my drivers to the PPC platform . Am
> > currently using consistent_alloc() and consistent_free() to
> > allocate/free (non-cached) DMA ble memory.
> > Is there any function/patch/macro, equivalent to
> > phy_to_virt()/virt_to_phy() for memory returned by consistent_alloc()?
> 
> Don't ever use concistant_alloc directly.  Always use
> dma_alloc_coherent() which will give you both virtual and bus address.

He's obviously not talking about 2.6 since he's mentioning
consistent_alloc().  I removed those PPC-specific APIs when I
updated our DMA API implementation in 2.6.

-Matt
