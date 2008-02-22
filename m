Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DE8EDE13B
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 04:01:34 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add support for binary includes. 
In-Reply-To: Your message of "Fri, 22 Feb 2008 10:08:20 CST."
	<20080222160820.GA19571@ld0162-tx32.am.freescale.net>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
	<20080222160820.GA19571@ld0162-tx32.am.freescale.net>
Date: Fri, 22 Feb 2008 10:24:56 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JSahk-0003ub-Eh@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Scott Wood mumbled:
> > 
> > Can I ask; what is the intended usage of such a thing?  How large
> > would a typical binary blob be?
> 
> I use it for embedding guest device trees in a hypervisor's device tree.

Why wouldn't we instead, say, extend the source sytax
to allow a sub-tree or an embedded tree, rather than
obscuring an opaque form of that guest device tree?

Thanks,
jdl
