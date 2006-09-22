Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id E2B4567B75
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 09:48:23 +1000 (EST)
Received: from midway.site ([71.117.233.155]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 16:38:18 -0700
Date: Fri, 22 Sep 2006 16:39:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-Id: <20060922163929.bb870ee1.rdunlap@xenotime.net>
In-Reply-To: <20060922233235.GB14213@austin.ibm.com>
References: <20060921231314.GW29167@austin.ibm.com>
	<20060922220629.GA4600@dreamland.darkstar.lan>
	<20060922233235.GB14213@austin.ibm.com>
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

On Fri, 22 Sep 2006 18:32:35 -0500 Linas Vepstas wrote:

> On Sat, Sep 23, 2006 at 12:06:29AM +0200, Luca wrote:
> > 
> > Space after function name? You put in other places too, it's not
> > consistent with the rest of the patch.
> 
> Oops. I was also coding on a different project recently, with a
> different style.  I'll send a revised patch in a moment.

Please change if()'s to use

	if (var == constant)
instead of
	if (constant == var)

also.  (or whatever condition is being used)  Thanks.


> > > +       if (pci_enable_device(pdev))
> > > +               printk (KERN_ERR "%s: device setup failed most egregiously\n",
> > > +                           sym_name(np));
> > 
> > Is the failure of pci_enable_device ignored on purpose?
> 
> No. :-( Thanks for the catch. I think I got cross-eyed staring at the code.

---
~Randy
