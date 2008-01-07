Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2341DDDE9F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 02:25:59 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Handle absolute pathnames correctly in dtc_open_file.
In-Reply-To: Your message of "Sun, 06 Jan 2008 16:46:24 CST."
	<20080106224623.GA8239@ld0162-tx32.am.freescale.net>
References: <20080104211045.GB28991@ld0162-tx32.am.freescale.net>
	<20080106033716.GL4326@localhost.localdomain>
	<20080106224623.GA8239@ld0162-tx32.am.freescale.net>
Date: Mon, 07 Jan 2008 09:25:56 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JBtrQ-0005Df-9Z@jdl.com>
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
> On Sun, Jan 06, 2008 at 02:37:16PM +1100, David Gibson wrote:
> > >  out:
> > > +	free((void *)file->dir);
> > 
> > That cast shouldn't be there.
> 
> It generates a constness warning otherwise.  I was on the fence over
> whether to just remove the constness (even though the data is never
> modified during its lifetime); would that be preferable?

The earlier patch was applied for functionality reasons.
If needed, a follow-up patch to sort this out is still welcome.

jdl
