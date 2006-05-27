Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 5C2EC67A3A
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 07:01:03 +1000 (EST)
Date: Sat, 27 May 2006 22:34:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] make ams work with latest kernels
Message-ID: <20060527203437.GD16612@elf.ucw.cz>
References: <1148383943.25971.2.camel@johannes>
	<1148465069.6723.26.camel@localhost.localdomain>
	<20060526173908.GA3357@ucw.cz>
	<1148760414.16989.59.camel@johannes.berg>
	<1148761919.3132.1.camel@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1148761919.3132.1.camel@deep-space-9.dsnet>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On So 27-05-06 22:31:58, Stelian Pop wrote:
> Le samedi 27 mai 2006 ? 22:06 +0200, Johannes Berg a écrit :
> > On Fri, 2006-05-26 at 17:39 +0000, Pavel Machek wrote:
> > 
> > > > This driver also provides an absolute input class device, allowing
> > > > the laptop to act as a pinball machine-esque joystick.
> > > 
> > > Is it useful to have /sysfs interface when we already have same data
> > > available as joystick?
> > 
> > Might be useful if you need to turn off the "joystick" because X gets
> > confused with it. Other than that, no.
> 
> /sysfs interface also exports the 'z' coordinate, the input interface
> does not.

Can that be fixed? z coordinate should be useful for input, too.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
