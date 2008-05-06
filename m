Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB598DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 10:10:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m460AR12009001
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 20:10:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m460AQTZ219342
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 18:10:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m460AQKT030829
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 18:10:26 -0600
Date: Mon, 5 May 2008 19:09:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Sam440ep support
Message-ID: <20080505190923.6123a6e5@zod.rchland.ibm.com>
In-Reply-To: <1210030805.21644.118.camel@pasglop>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<20080505135404.5c57720e@zod.rchland.ibm.com>
	<1210030805.21644.118.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Giuseppe Coviello <cjg@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 06 May 2008 09:40:05 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Mon, 2008-05-05 at 13:54 -0500, Josh Boyer wrote:
> > > +arch_initcall(sam440ep_i2c_of_init);
> > 
> > Ok, now I'm confused as to why you aren't doing this in your platform
> > file (which would make it specific, and therefore justify its
> > existence.
> 
> I addition, that gets called on all platforms, not only sam440ep, which
> is wrong.

Correct.  I was starting with code organization vs. specific comments
since it was all one big patch.  I'll get into details when it gets
split properly :).

josh
