Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C203DDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 07:19:08 +1100 (EST)
Date: Wed, 24 Dec 2008 12:18:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH -mm 1/3] USB: FHCI: Driver should be responsible for
	managing endpoint queues
Message-Id: <20081224121853.b46e9174.akpm@linux-foundation.org>
In-Reply-To: <20081224200845.GA1064@oksana.dev.rtsoft.ru>
References: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
	<20081224191303.GA21815@oksana.dev.rtsoft.ru>
	<20081224195935.GA11531@kroah.com>
	<20081224200845.GA1064@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Brownell <dbrownell@users.sourceforge.net>, Greg KH <greg@kroah.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, David,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Dec 2008 23:08:45 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> On Wed, Dec 24, 2008 at 11:59:36AM -0800, Greg KH wrote:
> > On Wed, Dec 24, 2008 at 10:13:03PM +0300, Anton Vorontsov wrote:
> > > Follow these changes for the FHCI driver:
> > 
> > Hm, would it just make more sense to respin the whole driver?  That way
> > it's never in the tree in a "broken" state?
> 
> It's for -mm tree. If I understand -mm workflow correctly, Andrew
> will merge all the fixes into the final patch before sending it to
> you in late -rc0 phase, when various -next git trees (on which this
> driver depend) will be merged into the Linus tree.
>
> Andrew, am I correct?

Yes, that's what I do.

I prefer to see the incremental patches once a patch has had review or
testing, so we can see which bits changed.  But if Greg intends to
merge this driver then he'd probably prefer a fresh new patch,
particularly as a) version 1 was only sent yesterday and b) he hasn't
merged version #1.
