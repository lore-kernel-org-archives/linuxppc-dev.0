Message-ID: <398B0C1F.DCB6641A@mvista.com>
Date: Fri, 04 Aug 2000 11:31:59 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Nguyen Xuan Hoang <hoang_nguyen@smartstors.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Usb slave API
References: <380658298.965240776157.JavaMail.root@web621-wrb.mail.com> <39888816.AEA4C307@mvista.com> <001101bffd79$167e2860$0401a8c0@hoangmobile> <005601bffe7f$9acd22e0$0401a8c0@hoangmobile>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > From my understanding the usb slave driver (not host) was done for MPC823
> > and MPC850, but I can't  find where it is

As Dan said, hopefully the annoucement will happen soon.

> >  nor what is the API for it (In
> > official linux kernel there's a API  for USB host function). Am I right or
> > too stupid?  I hope some people in this maillist can give a point.

Which kernel are you looking in?  USB support in the 2.2 kernel isn't
very stable. 2.4 has a very nice implementation and I think you can find
backports to the 2.2.  However backports are not always stable.
Basically the kernel provides slave (peripheral) drivers for the basic
peripheral classes, printer, scanner, mouse, keyboard, etc.  look in
drivers/usb for those files to use as examples.

 The first place to look is in the Documentation directory of the kernel
tree.  At the very least it will have pointers to where to find docs.
In this case (2.4), it provides some good descriptions of the USB API
and the various pieces that make up the USB stack.  I read a paper
called "Programming Guide for Linux USB Devices" that is pretty good.
you can find it at http://usb.in.tum.de/usbdoc .


Matthew Locke
Montavista Software
http://www.mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
