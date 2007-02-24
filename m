Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D032DDF01
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 10:34:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: debugging custom Xilinx boot loader with abatron and
	Montavistadevrocket
Date: Sat, 24 Feb 2007 15:34:05 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069AEE@MERCURY.inside.istor.com>
References: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com><1172267591.13040.30.camel@jaalaptop>
	<45a1b53e0702241440y76024946w20ba32658460388c@mail.gmail.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Wade Maxfield" <wmaxfield@gmail.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Wade:
=20
Since the MontaVista engineers have no clue as to how to use their =
product, and I had the same experience, the appropriate solution is to =
abandon their product until and unless they do have a clue as to how to =
use their IDE.
=20
The route using DDD/gdb is an appropriate one and building an .elf file =
is no problem with either uboot or Linux.
=20
Another thing to watch out for with Montavista is their gdb executable =
may or may not work correctly. If this is the case, you will need to get =
a gdb from gnu.org and cross compile it. Basically, they blew it on the =
toolchain also.
=20
Charles
=20

________________________________

From: linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org on behalf =
of Wade Maxfield
Sent: Sat 2/24/2007 2:40 PM
To: ppc
Subject: Re: debugging custom Xilinx boot loader with abatron and =
Montavistadevrocket


   Thanks!

   I did indeed mean to say "devrocket" when I said "MontaVista"

   I went down the DDD/gdb  route using the MontaVista command line =
tools.  Their ppc_405-gdb connects to the abatron bdi2000 as a gdb =
server.  I was able to get that to work to some extent.=20

    I did not ask my main question correctly enough.  Let me rephrase.

    My main question (for the MontaVista experts out there) is either

    1) In DevRocket, what kind of project do you choose to debug an =
externally build .elf file?=20
       MontaVista support engineers had no clue.

    or

    2) How do you use DevRocket to create a cross compiled set of code =
linked to a specific address. =20
       MontaVista support engineers also had no clue on this one.=20

   If either answer is no, OK. =20
  =20
    Now that I have the DDD/gdb/Abatron complex working, I don't think I =
absolutely need the DevRocket and its nice (but slow) facilities.  It =
would be nice to do the cross compile under DevRocket, but the Xilinx =
EDK is doing just fine.=20

    I will look into uboot later, when I do another attempt at getting =
linux into the system.

   I failed to mention that we have the system ace chip with a compact =
flash card, and it is apparently functional.  It provides all the =
"flash" that we need.  We do have some onboard flash for configuration =
data.=20

   Our project is simultaneously complex and simple.  It is complex in =
what it does ( a complicated receiver based on latest DSL technology), =
but simple in the household chores (linux is almost overkill, but we do =
need ethernet and all that implies).=20

  Interesting we can get PPC linux into 16 meg.  Once that happens, I'll =
try it again.

thanks,
wade
  =20


On 2/23/07, Jeff Angielski <jeff@theptrgroup.com> wrote:=20

	On Fri, 2007-02-23 at 10:11 -0600, Wade Maxfield wrote:=20
	>
	>   I want to debug a ppc custom boot loader with Montavista (since we
	> spent the money on it) under the Xilinx fx60.
=09
	Writing custom bootloaders is nontrivial.  Are you sure you really want
	to do that?
=09
	And what does MV have to do with the bootloader?


<snip>=20



	--
	Jeff Angielski
	The PTR Group
=09
=09
