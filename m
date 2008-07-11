Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 53294DE0A4
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 08:08:30 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4051041wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 15:08:28 -0700 (PDT)
Date: Fri, 11 Jul 2008 16:08:26 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080711220826.GD18239@secretlab.ca>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<4877B046.8070206@scram.de>
	<20080711191930.GA23723@polina.dev.rtsoft.ru>
	<20080711211813.GC18239@secretlab.ca>
	<20080711214614.GA22000@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080711214614.GA22000@polina.dev.rtsoft.ru>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 01:46:14AM +0400, Anton Vorontsov wrote:
> On Fri, Jul 11, 2008 at 03:18:13PM -0600, Grant Likely wrote:
> > On Fri, Jul 11, 2008 at 11:19:30PM +0400, Anton Vorontsov wrote:
> > > On Fri, Jul 11, 2008 at 09:11:02PM +0200, Jochen Friedrich wrote:
> > > > 
> > > > Shouldn't this be:
> > > > 		if (info.irq != NO_IRQ)
> > > 
> > > Maybe, maybe not. See
> > > 
> > > http://lkml.org/lkml/2005/11/21/211
> > > 
> > > I.e. maybe we should use "if (irq)". Or if we should use NO_IRQ, then we
> > > need to fixup all the users of .irq.
> > 
> > Yes, these are definitely wrong and need to be fixed.
> 
> In rc9? ;-)

I said no such thing.  :-)  It agree that it is too late for .26, but I
think is a reasonable goal to get fixed for 2.6.27.

g.
