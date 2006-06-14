Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86EE467A5D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 00:07:53 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Subject: RE: OpenFirmware framebuffer
Date: Wed, 14 Jun 2006 09:07:41 -0500
Message-ID: <00b601c68fbb$e9c2c570$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1150242815.13958.71.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, 'Nathan Lynch' <ntl@pobox.com>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Send us a copy of your dmesg log. Also, does the pegasos 
> firmware creates a "display" node in OF with the right type 
> and properties ?

dmesg log might be a bit clumsy to get but I will try.

Please tell me what the display node should have? I can check that. I
am curious though as it does seem to have worked.. it uses the mode I
set in firmware, cleans the screen and prints a message to display..
just not MUCH of a message. With previous "broken" firmware and kernels
I would get a garbage screen with the chrp_boot messages on it, but
yesterday this new message (welcome to Linux.. MSR, HID0 printout) was
a welcome change, but.. not a console so much as "not a blank screen".

dmws2: the current released firmware doesn't. But I get to test out all
these new broken features.. :3

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
