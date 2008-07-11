Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 52B0DDDEF1
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 07:46:17 +1000 (EST)
Date: Sat, 12 Jul 2008 01:46:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080711214614.GA22000@polina.dev.rtsoft.ru>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<4877B046.8070206@scram.de>
	<20080711191930.GA23723@polina.dev.rtsoft.ru>
	<20080711211813.GC18239@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080711211813.GC18239@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 03:18:13PM -0600, Grant Likely wrote:
> On Fri, Jul 11, 2008 at 11:19:30PM +0400, Anton Vorontsov wrote:
> > On Fri, Jul 11, 2008 at 09:11:02PM +0200, Jochen Friedrich wrote:
> > > 
> > > Shouldn't this be:
> > > 		if (info.irq != NO_IRQ)
> > 
> > Maybe, maybe not. See
> > 
> > http://lkml.org/lkml/2005/11/21/211
> > 
> > I.e. maybe we should use "if (irq)". Or if we should use NO_IRQ, then we
> > need to fixup all the users of .irq.
> 
> Yes, these are definitely wrong and need to be fixed.

In rc9? ;-)

Something tells me that even for 2.6.27 such change would be somewhat
late...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
