Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1AE667A6E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 09:12:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je1x9pv1mf.fsf@sykes.suse.de>
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
	<1112656372.26086.88.camel@gaston>
	<4240b91605040504525fd877e5@mail.gmail.com>
	<je1x9pv1mf.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 09:12:18 +1000
Message-Id: <1112742738.9517.45.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-04-05 at 14:39 +0200, Andreas Schwab wrote:
> Jerome Glisse <j.glisse@gmail.com> writes:
> 
> > I will try t look at radeon framebuffer see if i can find anythings.
> > Any idea of which change on that code may be the origin of this ?
> 
> I'd suggest looking at the changes between rc1 and rc2 first.  On my iBook
> G3 with Radeon M6 I'm also having problems with rc2, whereas rc1 is
> working fine.  I haven't found the time to look closer yet.

What problem specifically ?

Ben.
