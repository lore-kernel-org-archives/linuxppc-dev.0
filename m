Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1215236584.7424.2.camel@localhost>
References: <20080704190535.316377278@arndb.de>
	<20080704190806.964824190@arndb.de> <1215236584.7424.2.camel@localhost>
Content-Type: text/plain
Date: Sat, 05 Jul 2008 16:28:59 +1000
Message-Id: <1215239339.8970.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, arnd@arndb.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-07-05 at 15:43 +1000, Michael Ellerman wrote:
> > The current Cell IOMMU implementation sets the IOPTE_SO_RW bits in all IOTPEs
> > (for both the dynamic and fixed mappings) which enforces strong ordering of
> > both reads and writes. This patch makes the default behaviour weak ordering
> > (the IOPTE_SO_RW bits not set) and to request a strongly ordered mapping the
> > new DMA_ATTR_STRONG_ORDERING needs to be used.
> 
> We're sure that's safe?

I'd say it's not...

Ben.
