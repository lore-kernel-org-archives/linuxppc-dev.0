Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BB8D5DDDE0
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 02:50:07 +1100 (EST)
Date: Mon, 2 Feb 2009 18:50:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/6] USB: Fixes for fsl_qe_udc driver
Message-ID: <20090202155004.GA6764@oksana.dev.rtsoft.ru>
References: <20081225141402.GA30689@oksana.dev.rtsoft.ru>
	<F4CBCB9E-5C58-4F9B-B0B2-623C81DF1339@kernel.crashing.org>
	<20090107045341.GA15842@kroah.com>
	<3983606C-7DC0-4D3D-B523-4EE5C2BCB80E@kernel.crashing.org>
	<20090113164001.GA14370@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090113164001.GA14370@kroah.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel Kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 08:40:01AM -0800, Greg KH wrote:
> On Tue, Jan 13, 2009 at 09:49:39AM -0600, Kumar Gala wrote:
> > On Jan 6, 2009, at 10:53 PM, Greg KH wrote:
> >> On Tue, Jan 06, 2009 at 10:44:13PM -0600, Kumar Gala wrote:
> >>> On Dec 25, 2008, at 8:14 AM, Anton Vorontsov wrote:
> >>>> Hi all,
> >>>>
> >>>> Just resending some fixes that seem to be lost...
> >>>
> >>> Greg,
> >>>
> >>> What happened w/this patch set?
> >>
> >> As it was sent during the hollidays (on Christmas day at that), it's
> >> still in my "to-review" queue.  I'll get to it in a few days after I
> >> resync the USB tree with Linus.
> >
> > Any update on the review of these 6 patches?
> 
> It's in my queue, been busy with "real work" for a bit right now,
> sorry...

Hello Greg,

Can you please look into these patches? I think they all are 2.6.29
material, since the QE UDC driver is barely usable w/o these fixes.

Thanks,

p.s. And thank you for merging the FHCI driver!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
