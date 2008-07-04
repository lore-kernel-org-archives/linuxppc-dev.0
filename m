Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (gw01.aehr.com [64.32.191.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C8B7DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 11:39:54 +1000 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Need stable 2.6 kernel for TQM823L
Date: Thu, 3 Jul 2008 18:39:18 -0700
References: <200807021418.13596.tmaenner@aehr.com>
	<200807031159.30434.tmaenner@aehr.com>
	<20080703190440.GA3098@secretlab.ca>
In-Reply-To: <20080703190440.GA3098@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807031839.19123.tmaenner@aehr.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 03 July 2008 12:04:40 Grant Likely wrote:
> On Thu, Jul 03, 2008 at 11:59:29AM -0700, Thomas Maenner wrote:
> > > $ ls arch/powerpc/boot/dts/tqm*
> > > arch/powerpc/boot/dts/tqm5200.dts  arch/powerpc/boot/dts/tqm8555.dts
> > > arch/powerpc/boot/dts/tqm8540.dts  arch/powerpc/boot/dts/tqm8560.dts
> > > arch/powerpc/boot/dts/tqm8541.dts
> >
> > however, I found config files in the ppc tree:
> > ls arch/ppc/configs/TQM8*
> > arch/ppc/configs/TQM823L_defconfig
> > arch/ppc/configs/TQM850L_defconfig
> > arch/ppc/configs/TQM8260_defconfig
> > arch/ppc/configs/TQM860L_defconfig
> >
> > Is this stuff still working?
> > Do I still need to create a device tree?
>
> arch/ppc is depreciated and will disappear in 2.6.27.  I don't know if
> anyone is actively keeping 8xx support working in arch/ppc so you may
> experience significant breakage.
>
> g.

Not exactly what I was hoping to hear...

What are the reasons to not port these TQs to 2.6?
Lack of resources? Not enough interest?

Thanks again
Tom

-- 
Linux hackers are funny people: They count the time in patchlevels
--
Thomas Maenner
E-Mail: mailto:tmaenner@aehr.com
