Message-Id: <200011100030.eAA0URH11424@denx.local.net>
To: Kyle Harris <kharris@nexus-tech.net>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: multiple kernel images on TQM823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Nov 2000 18:53:47 EST."
             <3A0B390B.94A8BB06@nexus-tech.net>
Date: Fri, 10 Nov 2000 01:30:27 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kyle,

in message <3A0B390B.94A8BB06@nexus-tech.net> you wrote:
>
> I have a STK823 kit that I have just started playing with. I've rebuilt
> the kernel and also have some canned images that came with the CDK. I'm

The images on the CD-ROM are for the older TQmon firmware. They  will
not work with PPCBoot.

For PPCboot you have to  recompile  the  kernel  and  create  PPCBoot
images  using  the mkimage tool. For detailed instructions please see
the README in the PPCBoot directory.

> using ppcboot for the MPC823. The present kernel lives at 0x40020000
> (and boots fine). Can I load another kernel somewhere else in flash and

Yes, sure you can. The pre-installed kernel is just about 320  KB  if
it's  a 2.2.x version, or about 420 kB if it's a 2.4.x. It's probably
a good idea to play for safety first, so I think 40100000 is  a  good
address for the next kernel image.

> boot from it? I've tried loading images at 0x40200000, but I get a "Bad
> Magic Number" error when booting.

That means that it's not a PPCBoot image.

Please contact me directly if you need pre-build PPCboot images.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one  instruction  --  from  which,  by induction, one can deduce that
every program can be reduced to one instruction which doesn't work.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
