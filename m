Message-ID: <00d601c330f2$489159d0$0320a8c0@onstardevserv>
From: "Mark Schaefer" <junk@markschaefer.org>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "'linuxppc-embedded mailing list'" <linuxppc-embedded@lists.linuxppc.org>
References: <20030612121905.708CDC5FD7@atlas.denx.de>
Subject: Re: VxWorks.c ?? 
Date: Thu, 12 Jun 2003 10:52:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang,

    I can't find any chip that looks like it drives the USB interface.
There are a few buffers, I believe.  I know the USB wasn't used for the
pilot.  Only the two RS232's (one console), RS485 and ethernet were used.
It was in a plastic box that hid the JTAG port and LED's.  I'm not really
concerned about getting the USB working right now.

    Thanks for the BDM4GDB link.  It looks like that's my best option.  I
don't want to put more $$$ than I have to in it.  Since I'm trying to save
$150 (the cost of an RS-485 programmable thermostat), and learn some things
about embedded Linux, it doesn't make sense to spend $1600 on a programmer
:).

Thanks!

Mark
----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
Sent: Thursday, June 12, 2003 8:19 AM
Subject: Re: VxWorks.c ??

> in message <009c01c330d8$425ee3d0$040110ac@junior> you wrote:
> >
> > I'm trying to reverse-engineer a "home gateway" - used for a home
> > automation project I worked on. It currently runs VxWorks, but I'd
> > like to see if I can port Linux to it. From what I can tell, it's an
> > XPC860 with two serial ports, a USB port, a FEC and an Rs-485 port.
> > It has two FLASH chips and two RAM chips - probably 32MB of each.
>
> 860 with USB? So there is an external USB controller on the board?
>
> > First of all, I need to replace the VxWorks boot loader with U-Boot.
> > I have the VxWorks loader capable of loading files from my computer
> > via ftp, but the Linux kernel requires virtual memory support, which
> > the boot loader doesn't have. I've looked everywhere for "vxhack.c"
> > and all the ftp sites are gone.
>
> I have no doubt that using U-Boot is a Good Thing (TM) per se, but
> there is no real requirement to use it - you can load and start a
> Linux kernel using the VxWorks loader, too. You have to tweak the
> Linux kernel's bootstrap loader code a bit, though. There is NO
> requirement that the boot loader must support virtual memory - U-Boot
> doesn't do this either.
>
> > After that, I need to set up a development environment. I have
> > the ppc kernel source, but I'm not able to get libc and u-boot to
> > compile. Should I give up and just use the ELDK? Also, what JTAG
> > Emulators and
>
> It is an interesting experience to go through all steps necessary to
> build your own toolchain and to debug all the funny little details
> that can go wrong. But it's time consuming, too. If you just need the
> toolchain now, feel free to use the ELDK.
>
> If you want to build your own set of tools please go on, but I
> recommend to separate these two projects ;-)
>
> > programmers do you use that are compatible with Linux and MPC8xx?
>
> The BDI200 was already recommended. I agree with that statement 100%.
> On the other hand, the price is a bit high if you need the tool just
> for a hobby project. For the MPC8xx you can also use the BDM4GDB
> parallel port adapter. Not that powerful, not that fast, limited to
> 8xx CPUs, not as reliable, plus some other disadvantages if compared
> against the BDI2000. But the, you can either build it for negligible
> cost, or buy the ready-to-use adapter for just 50 Euro.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
