Date: Wed, 22 Sep 1999 11:05:56 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: hay@colorado.edu
cc: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>,
        linuxdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB driver not detecting mouse? (lots of detail)
In-Reply-To: <19990922174605.27906.rocketmail@web122.yahoomail.com>
Message-ID: <Pine.LNX.4.10.9909221104000.23206-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 22 Sep 1999, David Hay wrote:

> > I am loading (insmod) what I call usb-card-driver which in a makefile I
> > wrote
> > includes the following.  ohci.o usb.o ohci-debug.o usb-debug.o
> > 
> > I then load mouse.o on top of that.  I just noticed that I compiled the
> > hub.c
> > but I did not load it and the mouse is working.  But I have a 2-port card
> > which is just a root hub and I think hub.c is just for the extention hubs
> > only.
> > AFAIK
> 
> I belive this is correct.  I've been loading usbcore.o, usb-ohci.o and the
> mouse.o.  Well, I usually don't load mouse, because when I load usb-ohci, it
> only sees a single hub with no devices attached, so when mouse.o hits
> usb_register, it can't find a mouse device to register the driver with. :(

This is all from samba, yes?  Or sticking the 2.3.x usb into 2.2.x.  I've
been doing that for a while, and the easiest way it to just compile in
OHCI, mouse, hub & keyboard.

> > What I did differently to get it to work was just the XF68Config file.  I
> > read the USB-HOWTO and set it up acording to that.  So I have really
> > done nothing other than compile the modules and then load them with
> > insmod.  I have not set up the modules directory and conf.modules yet.
> 
> I think I know what I need to do with the XF68Config file to get the mouse
> working, but until I can get the driver to see the mouse, I'm going to stick
> with my ADB mouse :(

The new config tools for the new X work fine w/ setting up mice (gpm & X)
and for USB keyboards (or ADB & USB combos).

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
