Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: PPC_CELL_NATIVE should select PCI
Date: Wed, 1 Apr 2009 14:11:54 +0200
References: <alpine.LRH.2.00.0904011141550.13419@vixen.sonytel.be>
	<200904011245.01483.arnd@arndb.de>
	<1238583750.17330.125.camel@pasglop>
In-Reply-To: <1238583750.17330.125.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904011411.54932.arnd@arndb.de>
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

On Wednesday 01 April 2009, Benjamin Herrenschmidt wrote:
> On Wed, 2009-04-01 at 12:45 +0200, Arnd Bergmann wrote:

> > No, QPACE does not have any PCI devices whatsoever.
> 
> so something like select PPC_OF_PLATFORM_PCI if PCI would work you
> think ?


Yes, that sounds good.

	Arnd <><
