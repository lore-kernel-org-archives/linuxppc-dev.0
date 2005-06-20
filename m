Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id DC88667B21
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Jun 2005 20:38:24 +1000 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id E91324044
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Jun 2005 12:38:33 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 20 Jun 2005 12:38:18 +0200
References: <20050617191231.B23C0C1510@atlas.denx.de>
In-Reply-To: <20050617191231.B23C0C1510@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506201238.19121.david.jander@protonic.nl>
Subject: Re: problems on isp1362 driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 17 June 2005 21:12, Wolfgang Denk wrote:
> in message <000001c57347$04a45d00$07070a0a@luj> you wrote:
> > We are using Philips ISP1362 usb controller on our ppc-embedded system.
> > We have ported the phlips's driver, PHCI, to ppc. The Philips linux
> > driver is that of  2002.
>
> You cannot do that. The  Philips  driver  comes  uner  a  proprietary
> license  which  is  incompatible with the GPL. You must not use their
> driver in the context of a Linux kernel or any other GPLed  software.
> You  are  either  violating  the  GPL,  or  the  Philips  license. Be
> careful!!!

IANAL, but I think theoretically at least, it should be possible, if you 
manage to craft sort of a "GPL abstraction layer" around the philips driver, 
to shield it from "GPL influence" in the kernel, just like Nvidia and others 
do. To the letter of the GPL that is not possible, but AFAIK the linux kernel 
license grants an exception that permits binary-only drivers for instance.
Anyway, it probably is a bad and dangerous idea to try to pull this off. As 
for me, I decided it is much safer to stay as far away as possible from the 
philips source. Looking at it could be fatal for an OSS-coder like me (my 
eyes could get poisoned).
Here goes a big "BOOOO" to Philips for doing this in the first place :-(

Greetings,

-- 
David Jander
