Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B8FC67DCF
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 11:47:03 +1100 (EST)
Subject: Re: [PATCH 8/16] powerpc: add ps3 platform hvcalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061111112239.GB24288@lst.de>
References: <4554DAD7.2090709@am.sony.com>
	<200611110313.40940.arnd@arndb.de>  <20061111112239.GB24288@lst.de>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 11:46:53 +1100
Message-Id: <1163292413.4982.243.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 12:22 +0100, Christoph Hellwig wrote:
> On Sat, Nov 11, 2006 at 03:13:40AM +0100, Arnd Bergmann wrote:
> > On Friday 10 November 2006 21:02, Geoff Levand wrote:
> > > Adds the ps3pf hvcalls.
> > > 
> > > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> > 
> > This one reminds of the inline hcall abstraction layer I did
> > some time ago. The implementation in your patch is a lot
> > less elegant than both the pseries in its current incarnation
> > and the one that I did (IMHO). Any opinions on how we should
> > proceed here?
> 
> Please try to reuse Arnd's code as much as possible.  What's in
> this patch is more than ugly.

Last I heard, there wasn't complete agreement between Paulus and Arnd
about how those Hcalls should look like and Arnd patch, I think,
conflicts with something else (though it's not off the top of my mind, I
haven't paid too much attention there).

I asked Paulus and we agreed that Geoff should keep his current macros
for now, and we'll look into a general consolidation once it's in and
the Toshiba stuff is in too (it should be posted next week).

Ben.
