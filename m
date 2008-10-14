Return-Path: <jesse.brandeburg@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by ozlabs.org (Postfix) with ESMTP id 01D54DDF83
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 03:23:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [BUILD_FAILURE] 2.6.27-git2 - allyesconfig on
	powerpc	selectsCONFIG_INTEL_IOATDMA=y
Date: Tue, 14 Oct 2008 09:10:33 -0700
Message-ID: <36D9DB17C6DE9E40B059440DB8D95F52066E36C7@orsmsx418.amr.corp.intel.com>
In-Reply-To: <48F4627E.30300@myri.com>
References: <20081013101559.GA14372@linux.vnet.ibm.com>
	<20081013112631.GD29938@cs181140183.pp.htv.fi>
	<36D9DB17C6DE9E40B059440DB8D95F52066E2EAE@orsmsx418.amr.corp.intel.com>
	<48F391B9.1000206@myri.com>
	<20081013183503.GA28133@cs181140183.pp.htv.fi>
	<48F4627E.30300@myri.com>
From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
To: "Brice Goglin" <brice@myri.com>
Cc: Adrian Bunk <bunk@kernel.org>, e1000-devel@lists.sourceforge.net,
	netdev@vger.kernel.org, "Sosnowski, Maciej" <maciej.sosnowski@intel.com>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, "Kirsher,
	Jeffrey T" <jeffrey.t.kirsher@intel.com>, sam@ravnborg.org,
	Jeff Garzik <jgarzik@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brice Goglin wrote:
> Adrian Bunk wrote:
>> But considering that igb is in a similar situation it would be nice
>> if all 3 drivers would handle it the same way.
>>=20
>=20
> Jesse,
> What do you think of the below patch?

Seems like a much better solution.  I can have Jeff Kirsher work on the
equivalent patches for igb, and ixgbe today.

> I am not very familiar with Kconfig, but it seems to solve the
> problem.=20
> If a Kconfig guru could double-check...

Yeah, please Kconfig gurus on the list have a quick look.
