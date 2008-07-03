Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (gw01.aehr.com [64.32.191.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC1A6DE105
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 05:00:05 +1000 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Need stable 2.6 kernel for TQM823L
Date: Thu, 3 Jul 2008 11:59:29 -0700
References: <200807021418.13596.tmaenner@aehr.com>
	<20080703055819.GB643@secretlab.ca>
In-Reply-To: <20080703055819.GB643@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807031159.30434.tmaenner@aehr.com>
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

Thanks much Grant,

On Wednesday 02 July 2008 22:58:19 Grant Likely wrote:
> On Wed, Jul 02, 2008 at 02:18:13PM -0700, Thomas Maenner wrote:
> > Hi Guys,
> >
> > I have used the 2.4 kernel successfully on the TQM823L and 855s, and
> > wanted to try out a 2.6 version. So I downloaded the latest from Wolfgang
> > @ git.denx.de but I'm getting all sorts of compile errors....
> >
> > Before I continue to dive in, I wanted to ask the group some questions:
> > - Is 2.6 ported to the TQM8xx modules?
>
> $ ls arch/powerpc/boot/dts/tqm*
> arch/powerpc/boot/dts/tqm5200.dts  arch/powerpc/boot/dts/tqm8555.dts
> arch/powerpc/boot/dts/tqm8540.dts  arch/powerpc/boot/dts/tqm8560.dts
> arch/powerpc/boot/dts/tqm8541.dts
>
however, I found config files in the ppc tree:
ls arch/ppc/configs/TQM8*
arch/ppc/configs/TQM823L_defconfig  
arch/ppc/configs/TQM850L_defconfig
arch/ppc/configs/TQM8260_defconfig 
arch/ppc/configs/TQM860L_defconfig

Is this stuff still working?
Do I still need to create a device tree?

Thanks again

Tom

> Unfortunately, it doesn't look like any of the tqm8xx boards have been
> added to the device tree directory, so the answer is probably, 'no'.
>
> > - If so, is it stable?
>
> I believe 8xx support is stable in arch/powerpc, but you'll need to
> write a device tree file for the board.  Look for a similar board in
> arch/powerpc/boot/dts/ to use as a starting point.
>
> You'll probably also need to add a platform file to
> arch/powerpc/platforms/8xx that matches against your new device tree file.
>
> g.


-- 
Linux hackers are funny people: They count the time in patchlevels
--
Thomas Maenner
E-Mail: mailto:tmaenner@aehr.com
