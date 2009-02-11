Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D45BDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 09:45:46 +1100 (EST)
Date: Wed, 11 Feb 2009 14:45:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH] vmalloc: Add __get_vm_area_caller()
Message-Id: <20090211144509.d22feeb8.akpm@linux-foundation.org>
In-Reply-To: <20090211171804.7021.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20090211044854.969CEDDDA9@ozlabs.org>
	<20090211171804.7021.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 11 Feb 2009 17:22:47 +0900 (JST)
KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:

> > I want to put into powerpc-next patches relying into that, so if the
> > patch is ok with you guys, can I stick it in powerpc.git ?
> 
> hm.
> Generally, all MM patch should merge into -mm tree at first.
> but I don't think this patch have conflict risk. 
> 
> Andrew, What do you think?

We can sneak it into mainline later in the week?
