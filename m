Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F6EF67B96
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 09:53:46 +1000 (EST)
Subject: RE: OpenFirmware framebuffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: matt@genesi-usa.com
In-Reply-To: <024901c68f06$4aa71f00$99dfdfdf@bakuhatsu.net>
References: <024901c68f06$4aa71f00$99dfdfdf@bakuhatsu.net>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 09:53:35 +1000
Message-Id: <1150242815.13958.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, 'Nathan Lynch' <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-13 at 11:27 -0500, Matt Sealey wrote:
> Gentoo 2.6.15-r5 from the 2006.0 install CD.
> 
> It says "Welcome to Linux gentoo-2.6.15-r5" and then I see four
> lines, MSR, HID0 and hex printout of each.
> 
> That's it.
> 
> I get the usual messages spooled to the serial console. My args are;
> 
> boot cd /boot/pegasos console=ttyS1,115200,8n1 console=tty0 init=/linuxrc looptype=squashfs loop=/image.squashfs udev nodevfs cdroot
> root=/dev/ram0 video=ofonly

Send us a copy of your dmesg log. Also, does the pegasos firmware
creates a "display" node in OF with the right type and properties ?

Ben.
