Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17F9ADDDAD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 11:11:20 +1100 (EST)
Subject: Re: [PATCH] vmalloc: Add __get_vm_area_caller()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20090211144509.d22feeb8.akpm@linux-foundation.org>
References: <20090211044854.969CEDDDA9@ozlabs.org>
	<20090211171804.7021.KOSAKI.MOTOHIRO@jp.fujitsu.com>
	<20090211144509.d22feeb8.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 11:11:04 +1100
Message-Id: <1234397464.29851.20.camel@pasglop>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-11 at 14:45 -0800, Andrew Morton wrote:
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

That would be best.

Cheers,
Ben.
