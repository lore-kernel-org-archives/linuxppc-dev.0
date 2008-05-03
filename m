Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 246E5DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 22:06:21 +1000 (EST)
Date: Sat, 03 May 2008 21:05:15 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@gmail.com>, Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: powerpc boot regression
In-Reply-To: <1209653507.27240.7.camel@badari-desktop>
References: <20080501051304.GM20457@bakeyournoodle.com>
	<1209653507.27240.7.camel@badari-desktop>
Message-Id: <20080503205334.9A1A.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linux-kernel@vger.kernel.org, LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	akpm@linux-foundation.org, David Miller <davem@davemloft.net>,
	Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> On Thu, 2008-05-01 at 15:13 +1000, Tony Breeds wrote:
> > On Tue, Apr 29, 2008 at 11:12:41PM -0700, David Miller wrote:
> > > 
> > > This commit causes bootup failures on sparc64:
> > > 
> > > commit 86f6dae1377523689bd8468fed2f2dd180fc0560
> > > Author: Yasunori Goto <y-goto@jp.fujitsu.com>
> > > Date:   Mon Apr 28 02:13:33 2008 -0700
> > > 
> > >     memory hotplug: allocate usemap on the section with pgdat
> > 
> > 
> > <snip>
> > 
> > We're seeing a boot failure on powerpc.  git bisect points the problem
> > at this commit.   However reverting just this one comitt doesn't fix the
> > regression.  I also needed to revert
> > 04753278769f3b6c3b79a080edb52f21d83bf6e2 (memory hotplug: register
> > section/node id to free")
> > 
> > Problem seen on power4, power5 and ps3.
> 
> I don't see the problem on my power5 machine. Can you send the
> config ? Is CONFIG_SPARSEMEM_VMEMMAP enabled ?
> 
> Please let me know.

I heard sparc has the similar regression.

http://marc.info/?l=linux-kernel&m=120953950332044&w=2

If Kame-san's temporary patch fixes your problems, its cause may be same.


Thanks.

-- 
Yasunori Goto 
