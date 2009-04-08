Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 061D5DE059
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 04:47:44 +1000 (EST)
Date: Wed, 8 Apr 2009 13:47:36 -0500
From: Nathan Lynch <ntl@pobox.com>
To: michael@ellerman.id.au
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-ID: <20090408134736.682bd56d@manatee.lan>
In-Reply-To: <1239173283.10104.38.camel@localhost>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<1239173283.10104.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> wrote:

> On Wed, 2009-04-08 at 15:51 +1000, Tony Breeds wrote:
> > On Wed, Apr 08, 2009 at 03:08:55PM +1000, Michael Ellerman wrote:
> > 
> > > The getter routines in here could really multiplex their return values
> > > with a negative error code, which I generally prefer, but this works I
> > > guess.
> > 
> > I was hoping someone would notice and suggest it.  tag you're it!
> 
> I meant we /could/ change them, but we could also leave them, it's a bit
> of a coin-flip which is better. Nathan might have an opinion?

I think I had some reason for doing it this way, but I'm drawing a
blank right now.

In the meantime, can someone post the warnings that gcc emits for
cacheinfo.c, as well as the gcc version?  I can't reproduce them with
4.3.2 on Fedora.
