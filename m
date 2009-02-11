Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 748FEDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 19:32:02 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n1B8Mpds020420 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 11 Feb 2009 17:22:51 +0900
Received: from mt1.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n1B8Mnhn000865 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Wed, 11 Feb 2009 17:22:49 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D602745DE52
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:22:48 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 74DA745DE50
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:22:48 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 54D86E38005
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:22:48 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0ACB7E38002
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:22:48 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] vmalloc: Add __get_vm_area_caller()
In-Reply-To: <20090211044854.969CEDDDA9@ozlabs.org>
References: <20090211044854.969CEDDDA9@ozlabs.org>
Message-Id: <20090211171804.7021.KOSAKI.MOTOHIRO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Wed, 11 Feb 2009 17:22:47 +0900 (JST)
Cc: Linux Memory Management <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kosaki.motohiro@jp.fujitsu.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We have get_vm_area_caller() and __get_vm_area() but not __get_vm_area_caller()
> 
> On powerpc, I use __get_vm_area() to separate the ranges of addresses given
> to vmalloc vs. ioremap (various good reasons for that) so in order to be
> able to implement the new caller tracking in /proc/vmallocinfo, I need
> a "_caller" variant of it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It seems reasonable reason and this patch looks good to me :)
	Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>


> I want to put into powerpc-next patches relying into that, so if the
> patch is ok with you guys, can I stick it in powerpc.git ?

hm.
Generally, all MM patch should merge into -mm tree at first.
but I don't think this patch have conflict risk. 

Andrew, What do you think?
