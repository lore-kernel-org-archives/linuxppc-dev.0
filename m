Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 2A9D4B70AF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 15:00:24 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o7550Nua011811 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Thu, 5 Aug 2010 14:00:23 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 613D645DE51
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:00:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 40FA645DE4E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:00:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2BD571DB803C
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:00:23 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id DEA281DB803A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:00:22 +0900 (JST)
Date: Thu, 5 Aug 2010 13:55:31 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 5/9] v4  Allow memory_block to span multiple memory
	sections
Message-Id: <20100805135531.498625ab.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C581C61.1050408@austin.ibm.com>
References: <4C581A6D.9030908@austin.ibm.com> <4C581C61.1050408@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, Dave Hansen <dave@linux.vnet.ibm.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 03 Aug 2010 08:40:49 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> Update the memory sysfs code that each sysfs memory directory is now
> considered a memory block that can contain multiple memory sections per
> memory block.  The default size of each memory block is SECTION_SIZE_BITS
> to maintain the current behavior of having a single memory section per
> memory block (i.e. one sysfs directory per memory section).
> 
> For architectures that want to have memory blocks span multiple
> memory sections they need only define their own memory_block_size_bytes()
> routine.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
(But maybe it's better to get ppc guy's Ack.)
