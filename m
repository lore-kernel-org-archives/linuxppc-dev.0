Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79145DDF8D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 21:17:17 +1000 (EST)
Date: Wed, 23 Apr 2008 13:16:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Message-ID: <20080423131657.71d6312f@hyperion.delvare>
In-Reply-To: <200804221612.06745.laurentp@cse-semaphore.com>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<20080419162358.746b714c@hyperion.delvare>
	<480A2117.7020502@scram.de>
	<200804221612.06745.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Laurent,

On Tue, 22 Apr 2008 16:11:56 +0200, Laurent Pinchart wrote:
> Hi Jean,
> 
> On Saturday 19 April 2008 18:43, Jochen Friedrich wrote:
> > Jean Delvare wrote:
> > > I'm not sure. I didn't have the time to look at it myself, but I am
> > > under the impression that the powerpc folks are tired of having to wait
> > > for me and may push it to Linus through their tree? That would be fine
> > > with me, as I don't want to be the one delaying something many
> > > developers want (but I also can't sign patches I've not even read.)

I still don't know exactly what happened there... I think I saw some
"OpenFirmware i2c" patches go upstream yesterday? But not the ones
listed below, which I thought they depended upon.

> > The required patches are:
> > 
> > http://patchwork.ozlabs.org/linuxppc/patch?id=17833
> > http://patchwork.ozlabs.org/linuxppc/patch?id=17834
> > 
> > which are just the forward ported patches you sent to the poweprc mailing
> > list some time ago: 
> > 
> > http://patchwork.ozlabs.org/linuxppc/patch?id=16282
> > http://patchwork.ozlabs.org/linuxppc/patch?id=16283
> 
> Given that the required patches are just forward-ported versions of patches 
> you sent (and thus probably reviewed as well :-)), what's the best way to get 
> them in 2.6.26 (if at all possible) ?

It's not that easy. A lot of new new-style i2c drivers have shown up in
the kernel since I wrote my patches (themselves derived heavily from
Jon Smirl's). Even if Jochen's patches are based on mine, we still need
to take a careful look on how each driver is modified, I remember for
example that some v4l drivers were using the original new-style driver
binding in a way I did not expect. So I can't just sign these patches
and hope they didn't break anything. It needs care, and this requires
time.

I will do my best to get this done before the 2.6.26 merge window
closes, but I can't promise anything.

-- 
Jean Delvare
