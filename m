Message-ID: <38FE1766.3F0F5CD4@worldnet.att.net>
Date: Wed, 19 Apr 2000 13:30:30 -0700
From: Logan Hall <warrior514@worldnet.att.net>
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: usb in 2.3.99-pre5
References: <38FD4160.9A761C36@worldnet.att.net> <38FDD287.FAD51E6F@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
>
> Logan Hall wrote:
> >
> > hi-
> > I just got 2.3.99-pre5 to build thanks to geert, but my usb is all
> > messed up.  I have a biege g3 with a usb pci card and a usb kensington
> > turboball.  The trackball works with 2.3.99-pre3 and in pre5 is
> > recognized but it doesn't get hooked up to /dev/usbmouse.  Is there any
> > way i can get it connected to the /dev/ entry? or has the /dev entry
> > changed?  Thanks for any ideas.
>
> Do you have CONFIG_DEVFS_FS=y in your .config file? Then you should
> probably put devfs=nomount in the kernel args. I don't know if devfs and
> usb are already compatible. Lots of other things don't work with devfs,
> even if you manage to find the documentation and start devfsd correctly.
>

Nope.. I used menuconfig but i had this option turned off.


Also as for the changes between pre5 and pre3, my mixer still doesn't
work, although i have found that i can set up the sound levels in mac os
and they will work in linux.. although i still can not turn off the
internal speaker with any mixer program because they all say they can
not open the mixer, this was not a problem with 2.2.x.  Also my ethernet
still doesn't work, although the kernel still seems to think it does, no
link light on the hub and ihaven't been able to ping either way.

> --
> Martin

--

----
Logan Hall

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
