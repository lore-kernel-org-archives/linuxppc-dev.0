Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: [Cbe-oss-dev] [patch 11/11] powerpc/cell: Add
	DMA_ATTR_STRONG_ORDERING dma attribute and use in IOMMU code
Date: Sun, 6 Jul 2008 17:15:54 +0200
References: <20080704190535.316377278@arndb.de>
	<200807052351.39945.arnd@arndb.de>
	<1215296448.8970.14.camel@pasglop>
In-Reply-To: <1215296448.8970.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807061715.55112.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 06 July 2008, Benjamin Herrenschmidt wrote:
> I need to look closely at what the various bridge settings are. Drivers
> do expect DMA requests from one device to stay in order, at least up to
> what's defined in the PCI spec, which is pretty much fully ordered
> unless those devices set the PCIe (or X) relaxed ordering attribute.
> However, AFAIK, Axon doesn't convey that sort of ordering attributes
> from incoming transactions between the PCIe segment and the PLB5.

Yes, it would be very helpful if you can look into this a bit more.
The Axon specification is particularly confusing in this regard and
even though everyone I have asked so far told us that it's totally
fine, an extra person with more insight in the complete picture looking
into this would be good.

	Arnd <><
