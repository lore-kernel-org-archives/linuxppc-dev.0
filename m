Message-ID: <E1836A7F3557D311A14000805F9F36FCD4E389@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'Kyle Harris'" <kharris@nexus-tech.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: tcsetpgrp failed in terminal_inferior: Inappropriate ioctl fo
	r  device
Date: Fri, 29 Jun 2001 08:38:58 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kyle,

I have not resolved this issue but I experience the same thing, i. e.,
gdb runs OK but the messages are annoying. I think this msg has
something to do with the termios as the tcsetpgrp is a system
call under this kernel function.

Mike

> -----Original Message-----
> From:	Kyle Harris [SMTP:kharris@nexus-tech.net]
> Sent:	Thursday, June 28, 2001 8:44 AM
> To:	Pergola, Michael
> Subject:	Re: tcsetpgrp failed in terminal_inferior: Inappropriate
> ioctl for  device
>
> Hi,
>
> Did you ever resolve this issue? I see it also on 2 different 823
> platforms. On one, gdb runs fine (but the messages are annoying). On the
> other, this message appears and then gdb seems to hang.
>
> Thanks, Kyle.
>
> "Pergola, Michael" wrote:
> >
> > Hello,
> >
> > I have an Embedded Planet with a LITE_DW Motorola 823 PPC using a HIOX
> > interface board.
> > I am trying to debug a program sending out data from ttyS2 and reading
> it
> > back in on ttyS1. The
> > latest patch has been applied for the tty ports (kernel 2.2.14).
> > Whenever I attempt to debug on it using gdb, I get the following
> message:
> >      tcsetpgrp failed in terminal_inferior: Inappropriate ioctl for
> device
> >
> > Does anyone know what this message signifies?
> >
> > Here is a sample session:
> > sh-2.03# gdb ttytest
> > GNU gdb 5.0
> > Copyright 2000 Free Software Foundation, Inc.
> > GDB is free software, covered by the GNU General Public License, and you
> are
> > welcome to change it and/or distribute copies of it under certain
> > conditions.
> > Type "show copying" to see the conditions.
> > There is absolutely no warranty for GDB.  Type "show warranty" for
> details.
> > This GDB was configured as "powerpc-hardhat-linux"...
> > (gdb) b 69
> > Breakpoint 1 at 0x10000a9c: file ttytest.c, line 69.
> > (gdb) run ttyS2 ttyS1
> > Starting program: /home/test/ttytest ttyS2 ttyS1
> > [tcsetpgrp failed in terminal_inferior: Inappropriate ioctl for device]
> >
> > Regards,
> >      Michael Pergola
> >      Danfoss Air-Conditioning & Refrigeration Division
> >      7941 Corporate Blvd.
> >      Baltimore, MD  21236     (410) 931-8250 x4259
> >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
