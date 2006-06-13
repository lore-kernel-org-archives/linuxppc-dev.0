Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E87E67B3D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 02:27:44 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Nathan Lynch'" <ntl@pobox.com>
Subject: RE: OpenFirmware framebuffer
Date: Tue, 13 Jun 2006 11:27:34 -0500
Message-ID: <024901c68f06$4aa71f00$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20060613161115.GB26750@localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gentoo 2.6.15-r5 from the 2006.0 install CD.

It says "Welcome to Linux gentoo-2.6.15-r5" and then I see four
lines, MSR, HID0 and hex printout of each.

That's it.

I get the usual messages spooled to the serial console. My args are;

boot cd /boot/pegasos console=ttyS1,115200,8n1 console=tty0 init=/linuxrc looptype=squashfs loop=/image.squashfs udev nodevfs cdroot
root=/dev/ram0 video=ofonly

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations


> -----Original Message-----
> From: Nathan Lynch [mailto:ntl@pobox.com] 
> Sent: Tuesday, June 13, 2006 11:11 AM
> To: Matt Sealey
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: OpenFirmware framebuffer
> 
> Matt Sealey wrote:
> > 
> > I just booted up my Pegasos and tried the offb driver for 
> display and 
> > was rather disappointed. It just displays 4 lines about 
> HID0 and stuff 
> > and then waits around.
> > 
> > Is this all there is? Is there nothing more? Can't I get a 
> scrolling 
> > kernel output, and a penguin logo or am I missing the point? :)
> 
> Maybe someone can help if you give more details, e.g. the 
> kernel version, and exactly what messages are displayed 
> before it hangs.
> 
> 
