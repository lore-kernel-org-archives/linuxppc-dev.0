Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 3/6] cell: Enable spider workarounds on all PCI buses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20061219143452.376366000@arndb.de>
References: <20061219143240.705255000@arndb.de>
	<20061219143452.376366000@arndb.de>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 07:37:52 +1100
Message-Id: <1166560672.19254.75.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 15:32 +0100, Arnd Bergmann wrote:
> plain text document attachment
> (powerpc-cell-spider-mmio-workarounds-only-for-external-pci.diff)
> From: Jens Osterkamp <jens@de.ibm.com>
> Don't limit spider I/O workarounds to the first two buses.
> The IBM Cell blade has three of them (one PCI, two PCIe)
> and we want to handle them all.

Except that the current code doesn't deal with PCIe properly yet.

It's a separate dummy register afaik.

Ben.
