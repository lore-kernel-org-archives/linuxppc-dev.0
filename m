Message-ID: <001401c0d901$6b166b80$3a10530c@default>
From: "Navin Boppuri" <navin.boppuri@worldnet.att.net>
To: "Sacha J. Bernstein" <sachab@wciatl.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <686970000.986832826@sacha>
Subject: Re: Embedded PPC Root FIlesystem
Date: Wed, 9 May 2001 20:29:26 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's not really that bad. You do not need a PPC based desktop. Cross
compilers from the MVista people lets you build stuff on an x86 machine for
your MPC. For your file system, you can look at BootDisk HOWTO where they
talk about building a root file system from scratch.
http://www.linuxdoc.org/HOWTO/Bootdisk-HOWTO/
Also, you learn how to reduce the file system size to fit into your embedded
environment.
I would also suggest you read the PowerPC Embedded HOWTO by Graham Stoney.
http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO.html

Hope this helps.

Navin Boppuri

>
> I'm currently trying to build a complete (with gcc and all other toosl
> you'd expect to find on a full desktop install, but not X11) root
> filesystem for an embedded device (with hard drive).  Is there already one
> out there, or does anyone have any suggestions on how to do it?  I have no
> desktop PPC machines, only x86.  I'm currently using one of the boot
images
> from hard hat linux, but it doesn't have a compiler and some other things
I
> wanted.  This is all on a MPC857T processor.  I've done embedded linux on
> x86 machines before, and I'm now finding that it's more difficult than I
> would have thought when I don't have a desktop depelopment machine if the
> same archetecture...
>
> Thank You
>
> Sacha
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
