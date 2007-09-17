Return-Path: <hollisb@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F78CDDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 14:15:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8H37oAr013572
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 23:07:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8H4FeRD477424
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 22:15:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8H4Fd8N024024
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 22:15:40 -0600
Subject: Re: [PATCH] fix xmon input on 440
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070917033924.GA24914@lixom.net>
References: <1189802687.20625.74.camel@basalt>
	<20070917025223.GG32725@localhost.localdomain>
	<1189999598.17593.18.camel@localhost.localdomain>
	<20070917033924.GA24914@lixom.net>
Content-Type: text/plain
Date: Sun, 16 Sep 2007 23:15:21 -0500
Message-Id: <1190002521.16747.1.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-09-16 at 22:39 -0500, Olof Johansson wrote:
> On Sun, Sep 16, 2007 at 10:26:37PM -0500, Josh Boyer wrote:
> > On Mon, 2007-09-17 at 12:52 +1000, David Gibson wrote:
> > > On Fri, Sep 14, 2007 at 03:44:47PM -0500, Hollis Blanchard wrote:
> > > > Implement udbg_getc() for 440, which fixes xmon input.
> > > > Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > 
> > 
> > I fixed up the whitespace issues and applied it to my tree.  Oh, and
> > comments don't need semi-colons ;)
> 
> Well, there's a big difference between:
> 
> 	while (foo)
> 		/* moof */;
> 	return bar;
> 
> and:
> 	while (foo)
> 		/* moof */
> 	return bar;

Right, so this commit is broken:
http://git.infradead.org/?p=users/jwboyer/powerpc.git;a=commitdiff;h=81ec428065c01e37fb143ad31dc04fea27fddcac

-- 
Hollis Blanchard
IBM Linux Technology Center
