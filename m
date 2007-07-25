Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6D80ADDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 06:09:28 +1000 (EST)
Date: Wed, 25 Jul 2007 22:09:24 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
In-Reply-To: <46A7AC17.9060309@ru.mvista.com>
Message-ID: <Pine.LNX.4.60.0707252203160.6234@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<Pine.LNX.4.60.0707252130090.6234@poirot.grange>
	<46A7A8FB.5090909@ru.mvista.com>
	<Pine.LNX.4.60.0707252150540.6234@poirot.grange>
	<46A7AC17.9060309@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jul 2007, Sergei Shtylyov wrote:

> Guennadi Liakhovetski wrote:
> 
> > >   Wrong list to submit sych stuff, post to linux-ide.
> 
> > Not entirely. The patch (or other patches in the series) would also touch
> > ARM platforms in the mainline, currently using that driver. As I didn't 
> 
>    Was worth cross-posting to linux-ide anyway to get the IDE experts'
> feedback. ;-)

linux-arm* mailing lists do not allow cross-posting.

> > have a chance to test them due to lack of hardware, I posted on arm, asking
> > if anyone would test those platforms for me.
> 
>   ... and they laughed at you? ;-)

No, noone had that hardware either:-) Those who had preferred to forget 
about it, I guess.

> > It was largely in accordance with my own opinion, so, I chose to accept
> > it:-)
> 
>    It's not clear why you decided to waste time on it then. :-)

Because I myself was in the situation where my local version of the driver 
was filling with #ifdef's supporting all possible variations of our 
hardware, so, I switched it to platform_driver to clean up that mess. And 
then decided to ask if others would consider it useful. Just in case. I 
hoped they wouldn't.

> > > > doubt, just wanted to double-check. So, why do we now need a new legacy
> > > > (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver
> > > > exists?
> 
> > >   Good question (I know the answer but won't tell ;-).
> 
> > You've been very cooperative, thanks.
> 
>    In fact, I also highly doubt that we need it.  What we'd need is an OF
> driver.

Great, thanks. Now we have to find out why Alan acked it (added to cc).

Thanks
Guennadi
---
Guennadi Liakhovetski
