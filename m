Return-Path: <mmarek@suse.cz>
Received: from slunatko.site (r6cu202.net.upc.cz [89.176.98.202])
	by ozlabs.org (Postfix) with ESMTP id 2679BDDEE6
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Jul 2007 05:07:35 +1000 (EST)
Message-ID: <4686170D.2090105@suse.cz>
Date: Sat, 30 Jun 2007 10:40:45 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.22-rc6-mm1
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>	<200706291432.10128.m.kozlowski@tuxland.pl>
	<20070629134748.71adba1e.akpm@linux-foundation.org>
In-Reply-To: <20070629134748.71adba1e.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: xfs-masters@oss.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
	linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org,
	Jason Wessel <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> On Fri, 29 Jun 2007 14:32:09 +0200
> Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
>> anyway after unselecting XMON we can see:
>>
>>   CC [M]  fs/xfs/linux-2.6/xfs_ioctl32.o
>> fs/xfs/linux-2.6/xfs_ioctl32.c: In function 'xfs_ioc_bulkstat_compat':
>> fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: 'xfs_inumbers_fmt_compat' 
>> undeclared (first use in this function)
>> fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: (Each undeclared identifier is 
>> reported only once
>> fs/xfs/linux-2.6/xfs_ioctl32.c:334: error: for each function it appears in.)
>> make[2]: *** [fs/xfs/linux-2.6/xfs_ioctl32.o] Blad 1
>> make[1]: *** [fs/xfs] Blad 2
> 
> Michal cc'ed.  I think this is the one which was already reported but
> I haven't seen a fix yet?

Hi, I sent you an updated patch yesterday (should I've changed the
subject / started a new thread? This was my first patch so bear with
me... :)). Anyway, the mail with the fix is here:
http://lkml.org/lkml/2007/6/29/87

Michal
