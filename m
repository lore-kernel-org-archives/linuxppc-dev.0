To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdb load address and KERNELLOAD 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Apr 2001 22:05:34 EDT."
             <3ACA816E.71E4FA67@mvista.com>
Date: Wed, 04 Apr 2001 08:42:19 +0200
Message-Id: <20010404064224.72482281DB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3ACA816E.71E4FA67@mvista.com> Dan Malek wrote:
>
> The only BDM debugger that works successfully with Linux is the
> Abatron gdb/BDI2000, hosted on a Linux platform.

This is absolutely correct except for the word "only".

The BDM4GDB  project  at  sourceforge  (see  bdm4gdb.sourceforge.net)
provides all necessary information to build a home-made parallel port
adapter  (schematics, source extension to GDB) which allows to do the
same. If you cannot build a simple PCB  yourself,  we  offer  BDM4GDB
adapters  at  production  cost ($ 50, including a CD-ROM with sources
and binary for the modified GDB) as a service to the Linux community.

The main differences between the BDI2000 and BDM4GDB:

* BDI2000 connects to the Ethernet, BDM4GDB needs a parallel port  on
  a PC.
* BDI2000 has support for  many  CPU  types,  BDM4GDB  restricted  to
  MPC8xx (so far)
* BDI2000 has support for all comon flash types, BDM4GDB  needs  some
  more  work  in that area (but you can adapt it yourself when needed -
  it's Open Source)
* BDI2000 is much faster for code download / flash programming
* The BDI2000 costs around $ 2,500, BDM4GDB $ 50.

Shameless plug:

I will give a presentation "Debugging  of  Linux  Kernel  and  Device
Drivers  Using Low-Cost BDM Interface" featuring the BDM4GDB on May 4
at the 3rd Brunswick Linux Days, see
http://braunschweiger.linuxtage.de/programm/index.html

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
