Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4D7DDDE0A
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 07:49:01 +1100 (EST)
Date: Sun, 4 Nov 2007 21:48:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/3] Add device-tree aware NDFC driver
In-Reply-To: <47273BF4.80001@ru.mvista.com>
Message-ID: <alpine.LFD.0.9999.0711042118460.3089@localhost.localdomain>
References: <20071029201738.GA2022@ru.mvista.com>
	<alpine.LFD.0.9999.0710300235580.3186@localhost.localdomain>
	<47273BF4.80001@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine,

On Tue, 30 Oct 2007, Valentine Barshak wrote:
> Thomas Gleixner wrote:
> > On Mon, 29 Oct 2007, Valentine Barshak wrote:
> > 
> > > This adds a device-tree aware PowerPC 44x NanD Flash Controller driver
> > > The code is based on the original NDFC driver by Thomas Gleixner, but
> > > since it's been changed much and has initialization/clean-up completely
> > > reworked it's been put into a separate ndfc_of.c file. This version
> > > supports both separate mtd devices on each chip attached to NDFC banks and
> > > single mtd device spread across identical chips (not using mtdconcat) as
> > > well.
> > > The choice is selected with device tree settings. This has been tested
> > > on PowerPC 440EPx Sequoia board.
> > > Any comments are greatly appreciated.
> > 
> > Did I express myself not clear enough in my first reply or is this
> > just a repeated epiphany in my inbox ? 
> > You got plenty of comments to your patches, but you decided to ignore
> > them silently.
> > 
> > Darn, fix it the right way once and forever and please don't try to
> > tell me another heartrending "why I did it my way" story.
> > 
> > This all can be done with a nice series of incremental patches
> > including a fixup to the existing users.
> > 
> > We have enough dump and run shit in the kernel already.
> > 
> > No thanks,
> > 
> >    tglx
> 
> You know, you're really too tense Thomas. I'm not sure of the reason why
> you're being a complete nerve, but I'm feeling sorry for you.

You have a perception problem. I'm not tense, I'm grumpy.

Rest assured, that my nerves are completely fine despite of the fact
that you try to rack them.

> I'm not saying my approach is the best, but I was hoping for a discussion.
> I've reworked the patches according to the comments to the previous version
> and used my arguments to explain why I don't see much reason to mess with the
> code we currently have and added a separate _of version.

This is the exact point. You were asked to fix up the existing driver
instead of replacing it and to do it with a series of incremental
patches. You copied the old code anyway and modified it, so we want to
have this documented in the history. This is not my obsession, it's
common kernel coding practise. The fact that you do not see much
reason to do it does not change this at all.

> I'm sure you'd find some time to do it yourself "the right way once and
> forever" with a "nice series of incremental patches" to fix what we currently
> have (call it a "dump" or anything you like) and even maybe add new device
> tree support.

It might be time for you to try to understand how OSS development
works.

> I'm sorry if for some reason I've made you feel bad.

What do you expect, after you abused my Signed-off-by in a way which
might have tricked David into pulling your code as is? This was
pointed out to you and you did not even bother to apologize.

> This is the last time I disturb you with my e-mail, so please, forget it.

Interesting. I thought you wanted to get the patch in, so you probably
should ask yourself whether it is a good idea _not_ to talk to the
responsible maintainer.

If you gave up on that, it just makes it more obvious that you do not
want to work with the community and just wanted to dump your patch and
move along.

     tglx
