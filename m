Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B61CDDE791
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:20:08 +1000 (EST)
Date: Thu, 17 Jul 2008 19:20:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080717152006.GA26120@polina.dev.rtsoft.ru>
References: <1216133032.5345.73.camel@dax.rpnet.com>
	<20080715151917.GA30607@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0807161546010.12709@t2.domain.actdsltmp>
	<20080717041531.GA27243@secretlab.ca>
	<20080717140519.GA32617@polina.dev.rtsoft.ru>
	<20080717141335.GA2219@polina.dev.rtsoft.ru>
	<20080717150422.GC31932@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080717150422.GC31932@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	Trent Piepho <tpiepho@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 09:04:22AM -0600, Grant Likely wrote:
> On Thu, Jul 17, 2008 at 06:13:35PM +0400, Anton Vorontsov wrote:
> > On Thu, Jul 17, 2008 at 06:05:19PM +0400, Anton Vorontsov wrote:
> > [...]
> > > > I think it would be better to have a module that scans the device tree
> > > > for LED nodes and registers a single leds-gpio platform device for the
> > > > whole lot.
> > > > 
> > > > Thoughts?
> > > 
> > > I like the idea, thanks.
> > 
> > Ugh, no. The idea sounds good, but in practice it isn't, since we'll
> > have to handle suspend/resume ops ourselves. When we stick with the
> > device/driver model we're getting all this for free.
> 
> Won't the leds-gpio driver give you suspend/resume support?

Ah. I just wrongly read your message. You're purposing to use gpio
leds platform driver... I think this is doable, yes.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
