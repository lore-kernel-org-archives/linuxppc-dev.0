Message-ID: <38FDD287.FAD51E6F@wanadoo.fr>
Date: Wed, 19 Apr 2000 17:36:39 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Logan Hall <warrior514@worldnet.att.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: usb in 2.3.99-pre5
References: <38FD4160.9A761C36@worldnet.att.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Logan Hall wrote:
>
> hi-
> I just got 2.3.99-pre5 to build thanks to geert, but my usb is all
> messed up.  I have a biege g3 with a usb pci card and a usb kensington
> turboball.  The trackball works with 2.3.99-pre3 and in pre5 is
> recognized but it doesn't get hooked up to /dev/usbmouse.  Is there any
> way i can get it connected to the /dev/ entry? or has the /dev entry
> changed?  Thanks for any ideas.

Do you have CONFIG_DEVFS_FS=y in your .config file? Then you should
probably put devfs=nomount in the kernel args. I don't know if devfs and
usb are already compatible. Lots of other things don't work with devfs,
even if you manage to find the documentation and start devfsd correctly.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
