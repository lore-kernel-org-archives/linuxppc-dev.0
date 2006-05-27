Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id 9F457679FF
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 06:32:03 +1000 (EST)
Subject: Re: [PATCH] make ams work with latest kernels
From: Stelian Pop <stelian@popies.net>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148760414.16989.59.camel@johannes.berg>
References: <1148383943.25971.2.camel@johannes>
	<1148465069.6723.26.camel@localhost.localdomain>
	<20060526173908.GA3357@ucw.cz>
	<1148760414.16989.59.camel@johannes.berg>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 27 May 2006 22:31:58 +0200
Message-Id: <1148761919.3132.1.camel@deep-space-9.dsnet>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le samedi 27 mai 2006 à 22:06 +0200, Johannes Berg a écrit :
> On Fri, 2006-05-26 at 17:39 +0000, Pavel Machek wrote:
> 
> > > This driver also provides an absolute input class device, allowing
> > > the laptop to act as a pinball machine-esque joystick.
> > 
> > Is it useful to have /sysfs interface when we already have same data
> > available as joystick?
> 
> Might be useful if you need to turn off the "joystick" because X gets
> confused with it. Other than that, no.

/sysfs interface also exports the 'z' coordinate, the input interface
does not.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
