Date: Mon, 7 Jun 1999 10:07:41 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Gary Thomas <gdt@linuxppc.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: gdb 4.18-1
In-Reply-To: <XFMail.990607003153.gdt@linuxppc.org>
Message-ID: <Pine.LNX.4.10.9906071005080.9045-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Jun 1999, Gary Thomas wrote:
> On 06-Jun-99 Geert Uytterhoeven wrote:
> > Gdb 4.18-1 (from Debian potato) doesn't seem to beable to debug anymore :-(
                     ^^^^^^^^^^^^^
> > 
> >| [21:40:51]/home/geert/em86# gdb em86
> >| GNU gdb 4.18
> >| Copyright 1998 Free Software Foundation, Inc.
> >| GDB is free software, covered by the GNU General Public License, and you are
> >| welcome to change it and/or distribute copies of it under certain conditions.
> >| Type "show copying" to see the conditions.
> >| There is absolutely no warranty for GDB.  Type "show warranty" for details.
> >| This GDB was configured as "powerpc-unknown-linux-gnu"...
> >| (gdb) run
> >| Starting program: /export/home0/geert/em86/em86 
> >| Don't know how to run.  Try "help target".
> >   ^^^^^^^^^^^^^^^^^^^^
> >| (gdb) 
> > 
> > Any clues?
> > 
> 
> Where did you get GDB-4.18?  I had to make _many_ patches to
> get Linux/PPC support in there.

Debian.

> You can pick this up (the SRPM at least) from:
>   ftp://ftp.linuxppc.org/linuxppc/users/gdt/

Thanks!

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
