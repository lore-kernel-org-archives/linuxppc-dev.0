Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 80237DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 07:58:32 +1100 (EST)
Date: Wed, 24 Dec 2008 12:58:35 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 1/3] USB: FHCI: Driver should be responsible for
	managing endpoint queues
Message-ID: <20081224205835.GA14844@kroah.com>
References: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
	<20081224191303.GA21815@oksana.dev.rtsoft.ru>
	<20081224195935.GA11531@kroah.com>
	<20081224200845.GA1064@oksana.dev.rtsoft.ru>
	<20081224121853.b46e9174.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081224121853.b46e9174.akpm@linux-foundation.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 24, 2008 at 12:18:53PM -0800, Andrew Morton wrote:
> On Wed, 24 Dec 2008 23:08:45 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > On Wed, Dec 24, 2008 at 11:59:36AM -0800, Greg KH wrote:
> > > On Wed, Dec 24, 2008 at 10:13:03PM +0300, Anton Vorontsov wrote:
> > > > Follow these changes for the FHCI driver:
> > > 
> > > Hm, would it just make more sense to respin the whole driver?  That way
> > > it's never in the tree in a "broken" state?
> > 
> > It's for -mm tree. If I understand -mm workflow correctly, Andrew
> > will merge all the fixes into the final patch before sending it to
> > you in late -rc0 phase, when various -next git trees (on which this
> > driver depend) will be merged into the Linus tree.
> >
> > Andrew, am I correct?
> 
> Yes, that's what I do.
> 
> I prefer to see the incremental patches once a patch has had review or
> testing, so we can see which bits changed.  But if Greg intends to
> merge this driver then he'd probably prefer a fresh new patch,
> particularly as a) version 1 was only sent yesterday and b) he hasn't
> merged version #1.

I do intend to merge it, given that it's in a buildable format :)

So a merged version would be good for me.

thanks,

greg k-h
