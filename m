Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0463267D1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:25:25 +1100 (EST)
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20061102160009.GC4928@localhost.localdomain>
References: <528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
	<OF4DAC86D4.8F202745-ON8725721A.00550DB9-8525721A.00556835@us.ibm.com>
	<20061102160009.GC4928@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:25:19 +1100
Message-Id: <1162506319.10630.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 17:00 +0100, Sascha Hauer wrote:
> On Thu, Nov 02, 2006 at 10:32:53AM -0500, Stephen Winiecki wrote:
> > 
> >    I also have a question about 750xx platforms.  I currently am looking at
> >    adding platform code supporting IBM 750GX/CL eval boards.  Where would
> >    they go - as well as others like Buckeye/Chestnut if/when they move over
> >    to /powerpc?
> 
> I don't know - Lets wait for ben and others what they say about this
> approach.
> My intention with this patch is to try and motivate people to
> integrate their machines as a part of the multiplatform support, because
> it doesn't cost a thing.

And that's a great move :) Thanks for doing that work !

> The presence of the embedded6xx entry and the entries in the directory
> itself makes people think (me too) that the multiplatform thing is only
> for the big irons. I think it's better to unify the two ways of platform
> support where it's possible.

Yes. I've been wanting to get rid of it for some time.

As for new platforms, I tend to have no problem if they just create a
directory of their own (platforms/chesnut, etc...) though in some we
might want a grab bag for boards that really only need one file...

This could be a plaforms/misc, or platforms/simple, or just have them at
the root of platforms...

Ben. 
