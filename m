Message-ID: <3965F335.42ABEEFD@erols.com>
Date: Fri, 07 Jul 2000 11:11:49 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.17pre10-ben1 & dmasound & atfb driver
References: <200007071603.RAA18464@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> <snip>
> Also, someone posted some instructions on how to set up the new input layer
> but I can't seem to find them in my linuxppc archive  - I'm assuming that
> the new stack has been back-ported to 2.2.17pre10 which is why my adbmouse
> doesn't...

I can't find the message in my archive, but here's the skinny (mainly quoted
from BenH--I wrote it down :-) ):

Delete both /dev/usbmouse and /dev/mouse (I moved them to temp_* just in
case).
cd /dev
mkdir input
mknod input/mice c 13 63
ln -s input/mice mouse
ln -s input/mice usbmouse

and add:
 none   /proc/bus/usb     usbdevfs    defaults 0 0
to your /etc/fstab


HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
