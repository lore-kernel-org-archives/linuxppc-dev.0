Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0BBE6DDF97
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 05:01:50 +1000 (EST)
Message-ID: <481A1399.8020304@am.sony.com>
Date: Thu, 1 May 2008 12:01:45 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: powerpc boot regression
References: <20080429.231241.221824292.davem@davemloft.net>	
	<20080501051304.GM20457@bakeyournoodle.com>
	<1209653507.27240.7.camel@badari-desktop>
In-Reply-To: <1209653507.27240.7.camel@badari-desktop>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel@vger.kernel.org, LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	y-goto@jp.fujitsu.com, akpm@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:
> On Thu, 2008-05-01 at 15:13 +1000, Tony Breeds wrote:
>> On Tue, Apr 29, 2008 at 11:12:41PM -0700, David Miller wrote:
>> > 
>> > This commit causes bootup failures on sparc64:
>> > 
>> > commit 86f6dae1377523689bd8468fed2f2dd180fc0560
>> > Author: Yasunori Goto <y-goto@jp.fujitsu.com>
>> > Date:   Mon Apr 28 02:13:33 2008 -0700
>> > 
>> >     memory hotplug: allocate usemap on the section with pgdat
>> 
>> 
>> <snip>
>> 
>> We're seeing a boot failure on powerpc.  git bisect points the problem
>> at this commit.   However reverting just this one comitt doesn't fix the
>> regression.  I also needed to revert
>> 04753278769f3b6c3b79a080edb52f21d83bf6e2 (memory hotplug: register
>> section/node id to free")
>> 
>> Problem seen on power4, power5 and ps3.
> 
> I don't see the problem on my power5 machine. Can you send the
> config ? Is CONFIG_SPARSEMEM_VMEMMAP enabled ?


The bug is hit with ps3_defconfig.  It does not have
CONFIG_SPARSEMEM_VMEMMAP set.


-Geoff
