Date: Tue, 9 Mar 1999 09:36:52 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Tom Rini <tmrini@ntplx.net>
cc: "G. [iso-8859-1] Laurs" <laures@hp1.esiea.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: No-IDE kernel compile link errors
In-Reply-To: <Pine.SUN.4.02.9903090859070.14871-100000@sea.ntplx.net>
Message-ID: <Pine.LNX.3.96L.990309092723.1664A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 9 Mar 1999, Tom Rini wrote:

> On Mon, 8 Mar 1999, Hollis R Blanchard wrote:
> 
> > When I rerun 'make menuconfig', I find that the IDE stuff has been
> > re-enabled on me. My other changes were saved, though. Examining the
> > .config file, I find that CONFIG_BLK_DEV_IDE_PMAC and
> > CONFIG_PARIDE_PARPORT are both set to y.
> 
> The CONFIG_PARIDE_PARPORT is just a "test" variable, it doesn't turn
> on/off anything in the code, just when the config stuff is going on.  From
> what I remember of drivers/block/Config.in, that's prolly a good thing
> that it's set.
> 
> > On a related note, I've always wondered who maintains the Makefiles for the
> > kernel. Is it communal, and if so, are patches to the Makefiles submitted
> > just like source patches?
> 
> It sounds like you accidently set the CONFIG_BLK_DEV_IDE to Y in the
> arch-spec area (where early BootX Text and TotalImpact card support is).
> This ugliiness is fixed by one of the ide patches in the patches dfir on
> nmt.

I disabled all IDE everythings (I swear), including "Support for PowerMac IDE
devices (must also enable IDE)" in General setup. Note that when I disable
this and re-run menuconfig, it has been enabled again.

Also, even when I comment out all Makefile options that include the string
"IDE", I still get that link error. I (perhaps naively) assumed there's kernel
code that should be behind a #ifdef IDE but isn't.

I eventually gave in and just enabled the damn IDE stuff. Compiles on my
PowerCenter 132 take a lot longer then I'd like, and to have them fail every
time is very frustrating. This is not the machine to test this on.

However, since I really don't want anything to do with IDE in my kernel, I'll
hope this gets taken care of - or do the NMT patches mentioned fix it? FWIW, I
got my sources from NMT (the 3/7 vger snapshot).

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
