Message-ID: <19990922174605.27906.rocketmail@web122.yahoomail.com>
Date: Wed, 22 Sep 1999 10:46:05 -0700 (PDT)
From: David Hay <hay_dave@yahoo.com>
Reply-To: hay@colorado.edu
Subject: Re: USB driver not detecting mouse? (lots of detail)
To: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Cc: linuxdev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Ira K Weiny <iweiny@falcon.csc.calpoly.edu> wrote:
> I just got my USB mouse working!!!!

Congrats ;)

> I am loading (insmod) what I call usb-card-driver which in a makefile I
> wrote
> includes the following.  ohci.o usb.o ohci-debug.o usb-debug.o
> 
> I then load mouse.o on top of that.  I just noticed that I compiled the
> hub.c
> but I did not load it and the mouse is working.  But I have a 2-port card
> which is just a root hub and I think hub.c is just for the extention hubs
> only.
> AFAIK

I belive this is correct.  I've been loading usbcore.o, usb-ohci.o and the
mouse.o.  Well, I usually don't load mouse, because when I load usb-ohci, it
only sees a single hub with no devices attached, so when mouse.o hits
usb_register, it can't find a mouse device to register the driver with. :(

> What I did differently to get it to work was just the XF68Config file.  I
> read
> the USB-HOWTO and set it up acording to that.  So I have really done
> nothing
> other than compile the modules and then load them with insmod.  I have not
> set
> up the modules directory and conf.modules yet.

I think I know what I need to do with the XF68Config file to get the mouse
working, but until I can get the driver to see the mouse, I'm going to stick
with my ADB mouse :(


=====
------------------------------------------------------------
 David Hay                                     \|/ ____ \|/
 hay@colorado.edu                              ~@-/ oO \-@~
 http://home.earthlink.net/~dhay/              /_( \__/ )_\
 ~ Live well ~ Laugh often ~ Love much ~          \__U_/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
