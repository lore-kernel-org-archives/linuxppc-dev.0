Message-ID: <3BD98E26.89809145@imc-berlin.de>
Date: Fri, 26 Oct 2001 18:24:06 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Frederic Soulier <soulier@aztec-radiomedia.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB and MPC855T/860T ???
References: <3BD912A4.A623F870@imc-berlin.de> <02c101c15df4$58bb2e30$d8020101@aztec.local>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Frederic,

> Linux provides now a good USB hosts/devices support. You can have a look at
> the Linux USB Project page  : http://www.linux-usb.org/. You have to
> consider that your microcontroller doesn't integrate a USB host (if you want
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
