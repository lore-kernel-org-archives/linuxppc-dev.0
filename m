Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F21FB67B2F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 00:29:23 +1000 (EST)
Subject: RE: OpenFirmware framebuffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: matt@genesi-usa.com
In-Reply-To: <00b601c68fbb$e9c2c570$99dfdfdf@bakuhatsu.net>
References: <00b601c68fbb$e9c2c570$99dfdfdf@bakuhatsu.net>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 00:29:11 +1000
Message-Id: <1150295351.5874.5.camel@localhost.localdomain>
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

On Wed, 2006-06-14 at 09:07 -0500, Matt Sealey wrote:
> > Send us a copy of your dmesg log. Also, does the pegasos 
> > firmware creates a "display" node in OF with the right type 
> > and properties ?
> 
> dmesg log might be a bit clumsy to get but I will try.
> 
> Please tell me what the display node should have? I can check that. I
> am curious though as it does seem to have worked.. it uses the mode I
> set in firmware, cleans the screen and prints a message to display..
> just not MUCH of a message. With previous "broken" firmware and kernels
> I would get a garbage screen with the chrp_boot messages on it, but
> yesterday this new message (welcome to Linux.. MSR, HID0 printout) was
> a welcome change, but.. not a console so much as "not a blank screen".
> 
> dmws2: the current released firmware doesn't. But I get to test out all
> these new broken features.. :3

Better, send me a firmware image and I'll check what's up on my
pegasos :)

Ben.
