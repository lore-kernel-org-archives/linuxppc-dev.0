Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] Cell IOMMU static mapping support
Date: Mon, 28 Jan 2008 12:41:48 +0100
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
	<20080126025117.GA28066@lixom.net>
In-Reply-To: <20080126025117.GA28066@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801281241.49059.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 26 January 2008, Olof Johansson wrote:
> > 
> > So instead of having an IOMMU window that we use to temporarily map things
> > in and out of DMA'able space, at boot we create a 1:1 mapping for all of
> > memory. This obviously only works for devices that can do 64-bit DMA.
> 
> I don't get it. Why not disable the iommu instead?
> 

When you disable the iommu, the 32-bit devices stop working because
they can no longer access all of main memory.

The 1:1 mapping is in addition to the DMA window used for those devices,
not in place of it.

	Arnd <><
