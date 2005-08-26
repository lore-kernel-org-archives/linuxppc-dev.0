Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id A9AF1680A5
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 09:13:22 +1000 (EST)
Date: Fri, 26 Aug 2005 16:13:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050826231320.GH5541@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
	<20050826225509.GF5541@smtp.west.cox.net>
	<da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2005 at 07:07:01PM -0400, Dan Malek wrote:
> 
> On Aug 26, 2005, at 6:55 PM, Tom Rini wrote:
> 
> >Yes, it was.  With 2.6.13 and on i386 (and other arches that actually
> >make use of the question) it can be any of 100, 250 or 1000.
> 
> Well, 250 just seems wrong as I mentioned in a previous message.
> It will function, but an application is going to see lots of clock 
> jitter
> unless you work in multiples of 100.  My choices would be 100, 200,
> 500, or 1000.

That's an arguement for lkml.  But as I recall things, there shouldn't
be jitter, probably, with non multiples of 100.  There was some
discussion, and a fair bit of flaming about all of this on lkml.  I
think with some sort of numbers Linus might buy another choice added to
the list, but refuses anything "in theory" (this stems in part from the
must be 1000 crowd not being happy about 250 as the default).

-- 
Tom Rini
http://gate.crashing.org/~trini/
