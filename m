Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id 0FF5A67BC9
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:56:24 +1000 (EST)
Received: from midway.site ([71.117.233.155]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 17:56:22 -0700
Date: Fri, 22 Sep 2006 17:57:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-Id: <20060922175733.522c9e0b.rdunlap@xenotime.net>
In-Reply-To: <20060922235017.GD14213@austin.ibm.com>
References: <20060921231314.GW29167@austin.ibm.com>
	<20060922220629.GA4600@dreamland.darkstar.lan>
	<20060922233235.GB14213@austin.ibm.com>
	<20060922163929.bb870ee1.rdunlap@xenotime.net>
	<20060922235017.GD14213@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Luca <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Sep 2006 18:50:17 -0500 Linas Vepstas wrote:

> On Fri, Sep 22, 2006 at 04:39:29PM -0700, Randy.Dunlap wrote:
> > On Fri, 22 Sep 2006 18:32:35 -0500 Linas Vepstas wrote:
> > 
> > > On Sat, Sep 23, 2006 at 12:06:29AM +0200, Luca wrote:
> > > > 
> > > > Space after function name? You put in other places too, it's not
> > > > consistent with the rest of the patch.
> > > 
> > > Oops. I was also coding on a different project recently, with a
> > > different style.  I'll send a revised patch in a moment.
> > 
> > Please change if()'s to use
> > 
> > 	if (var == constant)
> > instead of
> > 	if (constant == var)
> 
> Yuck! Horrid coding style! No rational excuse for coding like that.
> Advice taken under protest; new patch shortly.

Just after my email, I saw this :)
http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115896769322020&w=2

---
~Randy
