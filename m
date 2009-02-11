Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id EDA8CDDDAE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 10:53:35 +1100 (EST)
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n1BNrXJb020981 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Thu, 12 Feb 2009 08:53:34 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B80B445DD74
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:53:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9B1D545DD72
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:53:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8453D1DB803A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:53:33 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 466BF1DB803C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 08:53:33 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vmalloc: Add __get_vm_area_caller()
In-Reply-To: <20090211144509.d22feeb8.akpm@linux-foundation.org>
References: <20090211171804.7021.KOSAKI.MOTOHIRO@jp.fujitsu.com>
	<20090211144509.d22feeb8.akpm@linux-foundation.org>
Message-Id: <20090212085156.C8DB.KOSAKI.MOTOHIRO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Thu, 12 Feb 2009 08:53:32 +0900 (JST)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	kosaki.motohiro@jp.fujitsu.com, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, 11 Feb 2009 17:22:47 +0900 (JST)
> KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:
> 
> > > I want to put into powerpc-next patches relying into that, so if the
> > > patch is ok with you guys, can I stick it in powerpc.git ?
> > 
> > hm.
> > Generally, all MM patch should merge into -mm tree at first.
> > but I don't think this patch have conflict risk. 
> > 
> > Andrew, What do you think?
> 
> We can sneak it into mainline later in the week?

I think this patch obiously doesn't have any regression risk.
I obey your judgement.
