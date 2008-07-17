Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id BC3AADE644
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:04:31 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so620355qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:04:30 -0700 (PDT)
Date: Thu, 17 Jul 2008 09:04:22 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717150422.GC31932@secretlab.ca>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
	<20080717041531.GA27243@secretlab.ca>
	<20080717140519.GA32617@polina.dev.rtsoft.ru>
	<20080717141335.GA2219@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717141335.GA2219@polina.dev.rtsoft.ru>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 06:13:35PM +0400, Anton Vorontsov wrote:
> On Thu, Jul 17, 2008 at 06:05:19PM +0400, Anton Vorontsov wrote:
> [...]
> > > I think it would be better to have a module that scans the device tree
> > > for LED nodes and registers a single leds-gpio platform device for the
> > > whole lot.
> > > 
> > > Thoughts?
> > 
> > I like the idea, thanks.
> 
> Ugh, no. The idea sounds good, but in practice it isn't, since we'll
> have to handle suspend/resume ops ourselves. When we stick with the
> device/driver model we're getting all this for free.

Won't the leds-gpio driver give you suspend/resume support?

g.
