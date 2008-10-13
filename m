Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id A6EDDDE516
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:36:07 +1100 (EST)
Date: Mon, 13 Oct 2008 21:35:03 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Brice Goglin <brice@myri.com>
Subject: Re: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on powerpc
	selectsCONFIG_INTEL_IOATDMA=y
Message-ID: <20081013183503.GA28133@cs181140183.pp.htv.fi>
References: <20081013101559.GA14372@linux.vnet.ibm.com>
	<20081013112631.GD29938@cs181140183.pp.htv.fi>
	<36D9DB17C6DE9E40B059440DB8D95F52066E2EAE@orsmsx418.amr.corp.intel.com>
	<48F391B9.1000206@myri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <48F391B9.1000206@myri.com>
Cc: e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org, "Sosnowski,
	Maciej" <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org, "Brandeburg,
	Jesse" <jesse.brandeburg@intel.com>, linuxppc-dev@ozlabs.org,
	"Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, sam@ravnborg.org,
	Jeff Garzik <jgarzik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 13, 2008 at 08:21:45PM +0200, Brice Goglin wrote:
> Brandeburg, Jesse wrote:
> > What we want, is myri10ge and ixgbe drivers that can build whether or not CONFIG_INTEL_IOATDMA is enabled.  IF CONFIG_INTEL_IOATDMA *is* enabled (which it should not be on PPC) then there are several cases we want to work:
> > CONFIG_INTEL_IOATDMA=m  ---> CONFIG_IXGBE=[m|n]
> > CONFIG_INTEL_IOATDMA=y  ---> CONFIG_IXGBE=[m|y|n]
> > CONFIG_INTEL_IOATDMA=n  ---> CONFIG_IXGBE=[m|y|n]
> > CONFIG_INTEL_IOATDMA depends on X86
> 
> I am not sure I want to prevent myri10ge=y just because ioatdma=m.
>...

Technically both solutions are possible, which to choose is just a 
policy decision you have to agree on.

In practice it will anyway only rarely matter.

But considering that igb is in a similar situation it would be nice if 
all 3 drivers would handle it the same way.

> Brice

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
