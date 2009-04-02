Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: PPC_CELL_NATIVE should select PCI
Date: Thu, 2 Apr 2009 15:15:11 +0200
References: <alpine.LRH.2.00.0904011141550.13419@vixen.sonytel.be>
	<1238583750.17330.125.camel@pasglop>
	<alpine.LRH.2.00.0904020931520.11458@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0904020931520.11458@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904021515.12082.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 02 April 2009, Geert Uytterhoeven wrote:
> | arch/powerpc/platforms/built-in.o:(.toc1+0x4e8): undefined reference to `pci_io_base'
> 
> due to arch/powerpc/platforms/cell/io-workarounds.c. I guess this file
> shouldn't be built when CONFIG_PCI=n?

Right, the I/O workarounds are specific to the spider PCI implementation,
so there is no point in having them without PCI support.

> As I don't have the hardware to test anyway, I'll give up.

BenK, can you try Geert's patch on QPACE?

	Arnd <><
