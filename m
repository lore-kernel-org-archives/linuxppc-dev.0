Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id B96B7DE2A6
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 04:59:35 +1100 (EST)
Date: Tue, 14 Oct 2008 20:58:22 +0300
From: Adrian Bunk <bunk@kernel.org>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Subject: Re: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on powerpc
	selectsCONFIG_INTEL_IOATDMA=y
Message-ID: <20081014175822.GA4710@cs181140183.pp.htv.fi>
References: <20081013101559.GA14372@linux.vnet.ibm.com>
	<20081013112631.GD29938@cs181140183.pp.htv.fi>
	<36D9DB17C6DE9E40B059440DB8D95F52066E2EAE@orsmsx418.amr.corp.intel.com>
	<48F391B9.1000206@myri.com>
	<20081013183503.GA28133@cs181140183.pp.htv.fi>
	<48F4627E.30300@myri.com>
	<36D9DB17C6DE9E40B059440DB8D95F52066E36C7@orsmsx418.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <36D9DB17C6DE9E40B059440DB8D95F52066E36C7@orsmsx418.amr.corp.intel.com>
Cc: e1000-devel@lists.sourceforge.net, netdev@vger.kernel.org, "Sosnowski,
	Maciej" <maciej.sosnowski@intel.com>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, "Kirsher,
	Jeffrey T" <jeffrey.t.kirsher@intel.com>, sam@ravnborg.org,
	Jeff Garzik <jgarzik@redhat.com>, Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 09:10:33AM -0700, Brandeburg, Jesse wrote:
> Brice Goglin wrote:
> > Adrian Bunk wrote:
> >> But considering that igb is in a similar situation it would be nice
> >> if all 3 drivers would handle it the same way.
> >> 
> > 
> > Jesse,
> > What do you think of the below patch?
> 
> Seems like a much better solution.  I can have Jeff Kirsher work on the
> equivalent patches for igb, and ixgbe today.
> 
> > I am not very familiar with Kconfig, but it seems to solve the
> > problem. 
> > If a Kconfig guru could double-check...
> 
> Yeah, please Kconfig gurus on the list have a quick look.

Brice's patch looks fine.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
