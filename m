Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030414152233.13543.qmail@web41803.mail.yahoo.com>
Date: Mon, 14 Apr 2003 08:22:33 -0700 (PDT)
From: Cedric Aubert <cedric_aubert@yahoo.fr>
Reply-To: cedric_aubert@yahoo.fr
Subject: uClibc Compiling problem
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Does anyone known why the file crtbeginS.o is absent
in the
ELDK 2.0.2 cross compiling tools (mpc860) ?

thanks

cedric

> -----Original Message-----
> From: Erik Andersen
> Sent: Friday, April 11, 2003 8:04 PM
> To: Cedric Aubert
> Cc: Uclibc
> Subject: Re: [uClibc]Compiling problem
>
>
> On Fri Apr 11, 2003 at 02:27:53AM -0700, Cedric
Aubert wrote:
> > Hi,
> >
> > I try to compile uclibc with cross environnement
for
> > ppc (mpc860) (gcc 2.95.4) of the ELDK 2.0.2
toolkit fron Denx.
> >
> > I have succesfully build uClibc 0.9.19 but without
the POSIX pthread
> > option.
> >
> > If I enable POSIX pthread option this error occur
:
> >
>
/home/installateur/ELDK/usr/lib/gcc-lib/ppc-linux/2.95.4/m860/pic/
> crtbeginS.
> > o: No such 	file or directory
> > 	make[1]: *** [shared] Error 1
> > 	make[1]: Leaving directory
> >
`/home/installateur/embedded-ppc/src/uClibc-0.9.19/libpthread'make:
> > ***
> > [shared] 	Erreur 2
> >
> > and It's right crtbeginS.o isn't exist. But what
is it
> > ??
>
> crtbeginS.o is supposed to be supplied by gcc.  It
is the PIC
> version of crtbegin.o that is used for
constructor/destructor
> support.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
