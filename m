Message-ID: <A3E34B558F5CD211B4980008C7A4A99003C584CD@sparrow.gso.mcs.marconi.com>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Cc: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Subject: RE: USB and MPC855T/860T ???
Date: Fri, 26 Oct 2001 12:54:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,

Search the linux-usb-devel mailing list at sourceforge for "1161" and you
should find source posted by Roman Weissgaerber for a Philips ISP1161.  It's
the only non-OHCI/UHCI external USB host controller I know of with a Linux
Driver.  Transdimension (and one other company who I can't remember right
now) also make an embedded host controller, but I don't know of a Linux
driver for either.

Hope that helps.

Kevin

-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Friday, October 26, 2001 12:24 PM
To: Frederic Soulier
Cc: LinuxPPC
Subject: Re: USB and MPC855T/860T ???



Dear Frederic,

> Linux provides now a good USB hosts/devices support. You can have a look
at
> the Linux USB Project page  : http://www.linux-usb.org/. You have to
> consider that your microcontroller doesn't integrate a USB host (if you
want
> one, you may reconsider your choice and look a the MPC-850 family).

Thanks for your reply.
Since we need Fast Ethernet we are kind of restricted to MPC855T/860T.
Using the above URL it's easy to find out about supported devices like
cameras, disks, whatever.
But finding information about supported chipsets is much more difficult.

And when I am talking about chipsets I don't mean PCI chipsets.

I am looking for a simple USB controller from Atmel, Cypress or so
supported by linuxppc!

Is linux/drivers/usb the right place to look for supported chips?

Any ideas?

Thanks.

--
Steven Scholz


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
