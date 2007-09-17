Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4A116DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 13:37:43 +1000 (EST)
Date: Sun, 16 Sep 2007 22:39:24 -0500
From: Olof Johansson <olof@lixom.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] fix xmon input on 440
Message-ID: <20070917033924.GA24914@lixom.net>
References: <1189802687.20625.74.camel@basalt>
	<20070917025223.GG32725@localhost.localdomain>
	<1189999598.17593.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189999598.17593.18.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 16, 2007 at 10:26:37PM -0500, Josh Boyer wrote:
> On Mon, 2007-09-17 at 12:52 +1000, David Gibson wrote:
> > On Fri, Sep 14, 2007 at 03:44:47PM -0500, Hollis Blanchard wrote:
> > > Implement udbg_getc() for 440, which fixes xmon input.
> > > Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > 
> 
> I fixed up the whitespace issues and applied it to my tree.  Oh, and
> comments don't need semi-colons ;)

Well, there's a big difference between:

	while (foo)
		/* moof */;
	return bar;

and:
	while (foo)
		/* moof */
	return bar;

:-)
