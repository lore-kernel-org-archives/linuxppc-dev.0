Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id E5540688D6
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Dec 2005 07:39:44 +1100 (EST)
Date: Sat, 24 Dec 2005 21:17:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051224201753.GA26801@elf.ucw.cz>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	<20051129000615.GA20843@hansmi.ch>
	<20051130223917.GA15102@hansmi.ch>
	<20051130234653.GB15102@hansmi.ch>
	<1133533712.23129.25.camel@localhost.localdomain>
	<20051204224221.GA28218@hansmi.ch> <1135382385.4542.8.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1135382385.4542.8.camel@gaston>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> Ok, I finally received my new laptop (PowerBook5,8 15"). I tried the
> latest patch you posted, and while the kernel driver seem to work ok
> (though you can feel the lack of a proper acceleration curve), the
> synaptics driver in X doesn't work in any useable way. I updated the one
> that comes with breezy to whatever was the latest on the author web site
> (.44 I think) and while it detected the tracpkad, the result was soooooo
> slooooow that it was totally unseable. I've tried the config tool that
> comes with KDE for it but couldn't "boost" it to anything useful. Is
> that expected or is there still issues to be resolved in the driver ?
> I'm tempted to add some minimum support for a proper acceleration curve
> in the kernel driver in fact...

I do not think you should add it inside *kernel*. Proper acceleration
support really belongs to X...
								Pavel
-- 
Thanks, Sharp!
