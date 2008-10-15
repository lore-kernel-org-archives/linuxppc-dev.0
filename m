Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 551ACDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 15:46:08 +1100 (EST)
Subject: Re: gigE 2.6.27 USB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <48F479ED.1030500@hypersurf.com>
References: <48F32451.7020303@hypersurf.com> <48F479ED.1030500@hypersurf.com>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 15:45:59 +1100
Message-Id: <1224045959.8157.424.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 03:52 -0700, Kevin Diggs wrote:
> Kevin Diggs wrote:
> > Hi,
> > 
> >     I managed to wrestle my gigE to the ground and get it to boot
> > 2.6.27. I have, however, noticed that some messages are showing up in
> > dmesg. There are alot of them. They are continuous. They appear to come
> > from drivers/usb/core/hub.c:2916. It looks like they come in pairs (this
> > beast has two ports (root hubs)). I plugged in a USB CF reader. It
> > appears to work. The keyboard and mouse (a Logitech wireless receiver)
> > seems to work. 2.6.24 did not do this.
> > 
> > kevin
> > 
> 	For what it is worth, I tricked a laptop into booting 2.6.27. It
> does not appear to generate these messages. The PowerMac is running
> Yellow Dog 4.

It would be a lot more useful if you included informations in your
report such as :

 - The actual error output
 - The full dmesg log
 - Informations about the adapter including output of lsusb -v
 - How do you actually trigger the problem

It would be even more useful if you CC'ed some relevant list such
as the linux-usb one too :-)

Cheers,
Ben.
