Message-ID: <37EA63E2.1119D7EE@broadlink.com>
Date: Thu, 23 Sep 1999 17:31:14 +0000
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Questions on the MPC8xx-2.3.10 realease.
References: <19990923150552.23602.rocketmail@web601.yahoomail.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sébastien tadéoni wrote:
> 
> Hi PPCpeople;
> 
> I worked recently on the mpc8xx-2.3.10 sources, and I
> had less problem for compilation than with the 2.2.5
> release, but it stays some 'undefined reference to
> :kbd_pt_regs, fg_console, no_scroll.....'.
> 
> I think it is a configuration problem, but I don't
> find any solution (and I wonder if I will find the
> good configuration one day). I noticed like Brendan
> that some parameter are configured even if you didn't
> want.
> I edited the autoconf.h but no really changes.

I suggest tracking down the Makefile that is building the
unwanted feature and comment out the lines that build it.
It's not the cleanest solution, but it has worked for me.

> 
> According to Dan, it seems to be tooo difficult to
> cross compile on a host pentium machine (I begin to be
> mainly agree with him),so I'm going to obtain a
> powermac station.
> 
> However I would like to know before if someone has
> already succeeded to build a zImage or zImage.initrd
> configured for a MPC860 MBX board on a host pentium
> (II 400) station?

I have successfully built both a zImage and zImage.initrd 
for kernel 2.2.5 for an RPX-Lite (MPC850) board on a PII-350 
station running RedHat 5.2.  I used binutils-2.9.1.0.19a and
egcs-1.1.2 cross-compiler.

> 
> Good Day.
> Sébastien Tadéoni

-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
