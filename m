Message-ID: <390594BF.97FD809E@mondonet.net>
Date: Tue, 25 Apr 2000 14:51:11 +0200
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: Bernhard Reiter <bernhard@intevation.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze
References: <20000424161311.23404.qmail@web1705.mail.yahoo.com> <20000424191708.C16557@cheops.usf.Uni-Osnabrueck.DE> <39058B20.7D29A470@mondonet.net> <20000425144459.E22219@cheops.usf.Uni-Osnabrueck.DE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bernhard Reiter wrote:
>
> On Tue, Apr 25, 2000 at 02:10:08PM +0200, Mario Scarpa wrote:
> > Bernhard Reiter wrote:
> > >
> > > On Mon, Apr 24, 2000 at 09:13:11AM -0700, Gabriel Ricard wrote:
> > > > I've had some similar problems, sometimes it bombs
> > > > compiling the kernel, sometimes it locks up for no
> > > > apparent reason while it's running the screen saver
> > > > and hasn't been in use for a while. I haven't a clue
> > > > what is going on...
> > >
> > > Sound like exactly like the symtoms of my problem.
> > >         Bernhard
> >
> > Same here. I would say that it all started when I bought
> > my USB mouse and started using the USB bus: before I was
> > using the trackpad and do not remember about similar locks.
> > Just a hint.
>
> So do you think, just not pluggin in the usb mouse might help?
> This should be easy to test. Or do I need a kernel without usb support?

When I was not using my USB mouse I neither had the support
into the kernel; if it's not a great deal to you we can try
not to use (and not to enable) USB for a while and see what
happens. Due to the type of crash (total hang) it's quite
difficult to me to find out what's wrong so having a hint about
the possible cause could tighten the search a lot.


--
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
