Return-Path: <marcelo.tosatti@cyclades.com>
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk
	[195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E10A92BC0F
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 14:03:07 +1000 (EST)
Date: Fri, 15 Oct 2004 23:13:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041016021353.GA6388@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20041015154946.GB3957@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041015154946.GB3957@logos.cnet>
Cc: linuxppc-dev@ozlabs.org, 'Song Sam' <samlinuxppc@yahoo.com.cn>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 15, 2004 at 12:49:46PM -0300, Marcelo Tosatti wrote:
> On Tue, Sep 21, 2004 at 01:03:29PM -0400, Dan Malek wrote:
> > 
> > On Sep 21, 2004, at 7:59 AM, Smith, Craig wrote:
> > 
> > >Genius. That patch appears to work for me as well.
> > 
> > The fact this works indicates a subtle memory management
> > problem elsewhere.  I don't know what that is at this
> > point.  This hack is in a piece of generic code that works
> > properly on all other PowerPC cores, so it isn't going to
> > ever appear in the public sources.
> > 
> > I suggested this change to a few people hoping the information
> > would lead them to finding the real problem, not that it
> > should be perpetuated as a "fix" to make 8xx work.
> > I don't personally have time to work on this right now,
> > so anyone using 8xx should be looking for the real
> > cause and solution, not using this to create products.
> 
> Do you know the real cause Dan ?
> 
> As I told you, we are porting our sub-sub-architecture 
> to v2.6, and need that bug fixed at some time.
> 
> Lots of other people do.

I can try to fix it if you dont have time, do you know what is 
wrong and requires fixing? I'm not familiar with low-level PowerPC
memory management, but I can try.

Can you help, or are you planning on fixing this yourself (who
was the necessary knowledge, as soon as time allows) ?

I know Pantelis seems to have necessary knowledge to it. Pantelis?
