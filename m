To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860T FEC problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Sep 2002 02:58:50 +1200."
             <8D7C5F56B409554D9D46AC22195807F3061A2F@exchwenz01.smtp.dmcwave.co.nz>
Date: Mon, 09 Sep 2002 17:29:24 +0200
Message-Id: <20020909152930.0930CFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Rod,

can you please use a standard way to quote text? In this  message  it
is impossible for the reader to decide what was _my_ text, and which
is yours.

In message <8D7C5F56B409554D9D46AC22195807F3061A2F@exchwenz01.smtp.dmcwave.co.nz> you wrote:
>
>  -----Original Message-----
> From: 	Wolfgang Denk [mailto:wd@denx.de]
> Sent:	Saturday, September 07, 2002 10:15 AM
> To:	o_y
> Cc:	linuxppc-embedded@lists.linuxppc.org
> Subject:	Re: MPC860T FEC problem
>
>
> Hi,
>
> in message <MBBBIOFIICDAPDMKHBDEKEDLCAAA.o_yahav@netvision.net.il> you
> wrote:
> >
> > I'm trying to port linux 2.2.14 on MPC860T and busybox as initrd.
>
> 2.2.14 is prehistoric stuff. Don't waste your time on  all  the  bugs
> and problems that have been fixed since.

This was me.

> We are using this kernel and it is working find for us.

But this isn't my text!

> > I have not seen any initializetion of the BCSR4 so i initialize it with
> the
> > value
> > that ppcboot uses , so the ENABLE led is on too.
>
> Ummm... What's BCSR4? If PPCBoot initializes it, why do you  have  to
> initialize it again?

[me]

> Like Wolfgang said why reinvent the wheel

[not me]

> > The device isn't working even when i use ppcboot (i configured ppcboot to
> > use it).
>
> Sic! So get PPCBoot running first.
>
> > 1. Why there is no initializetion of BCSR4 in the original code?
> > 2. If BCSR4 must be initialized , what is the correct value?
> > 3. Is any one have a code that succeeded getting FEC device to work?
>
> Most of this depends on your hardware.  We are using the FEC with this
> kernel version and it is working fine.  Get the 2.2.14 kernel from
> Wolfgang's FTP site if it is still on there the FEC code and lots of other
> goodies work with this kernel version.

[not me]

But the 2.2.14 kernel is still there, unused and  unmaintained  since
November 2000.

> Sometimes you cannot upgrade to a new kernel version this is possibly
> political and not a design decision.  Sometime there is also no reason to
> upgrade to a newer kernel version and have to retest all possible variants
> of device with the new kernel version.

Sure. But there comes a point in time when it just doesn't make sense
to add more new features to old software - especially when  you  find
that  you  spend more effort on fixing old bugs that it would take to
switch to a new version.

Our 2.4.4 kernel is a good example for this problem.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As long as we're going to reinvent the wheel again, we might as  well
try making it round this time.                        - Mike Dennison

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
