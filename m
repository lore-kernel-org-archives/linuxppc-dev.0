Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: PPC_CELL_NATIVE should select PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200904011245.01483.arnd@arndb.de>
References: <alpine.LRH.2.00.0904011141550.13419@vixen.sonytel.be>
	<1238579652.17330.124.camel@pasglop> <200904011245.01483.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 22:02:30 +1100
Message-Id: <1238583750.17330.125.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-01 at 12:45 +0200, Arnd Bergmann wrote:
> On Wednesday 01 April 2009, Benjamin Herrenschmidt wrote:
> > On Wed, 2009-04-01 at 11:42 +0200, Geert Uytterhoeven wrote:
> > > PPC_CELL_NATIVE selects PPC_OF_PLATFORM_PCI, but not the underlying PCI,
> > > causing build failures if PCI is not set.
> > 
> > Maybe it should only select it if PCI is enabled ? Is qpace using PCI ?
> 
> No, QPACE does not have any PCI devices whatsoever.

so something like select PPC_OF_PLATFORM_PCI if PCI would work you
think ?

Ben.
