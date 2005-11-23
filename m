Return-Path: <david-b@pacbell.net>
Received: from smtp114.sbc.mail.mud.yahoo.com (smtp114.sbc.mail.mud.yahoo.com
	[68.142.198.213]) by ozlabs.org (Postfix) with SMTP id EF340687E9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 06:05:24 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Date: Wed, 23 Nov 2005 10:58:42 -0800
References: <1132715288.26560.262.camel@gaston>
	<20051123171041.GC26149@kroah.com>
In-Reply-To: <20051123171041.GC26149@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200511231058.43772.david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 23 November 2005 9:10 am, Greg KH wrote:
> On Wed, Nov 23, 2005 at 02:08:07PM +1100, Benjamin Herrenschmidt wrote:
> > This patch applies on top of 

Ben, I'll look at this patch today.


> > the patch that moves the PowerMac specific 
> > code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> > upstream yet for reasons I don't fully understand (why does USB stuffs
> > has such a high latency for going upstream ?), I'm sending it as a reply
> > to this email for completeness.
> 
> Sorry, I hadn't seen it, otherwise I would have sent it on.
> 
> David, are you ok with the patch Ben sent on as a followup?

It should be the same as 

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/usb-ohci-move-ppc-asic-tweaks-nearer-pci.patch

which is already in your queue, just it's not yet upstream.
I posted it before RC1 came out, but evidently not before
your RC1-merge-to-Linus window had closed.

- Dave
