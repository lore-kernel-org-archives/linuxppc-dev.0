Message-ID: <39F5EB6A.FFC195FA@snmc.com>
Date: Tue, 24 Oct 2000 15:04:58 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: clark@esteem.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Talking to the parrallel i/o ports
References: <5.0.0.25.1.20001024094825.00a47240@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn,

Sorry for the confusion.  You will need to download the tarball for the
qslinux source, expand that out, and then look in the directories
snmc/qslinux/kernel and snmc/qspin.

You can download the latest kernel tarball from:

	ftp://qslinux.org/pub/qslinux/

Regards,
Daris


clark@esteem.com wrote:
>
> Hi Daris,
>
>          I'm having a little trouble locating the source you were talking
> about. I have tried looking at http://qslinux.org/snmc/qslinux/kernel  and
> http://qslinux.org/snmc/qspin but they come up as 404 Not Found. I have
> also looked at your ftp site under ftp://qslinux.org/snmc/qslinux/kernel
> and ftp://qslinux.org/snmc/qspin with no luck. I was able to find
> ftp://qslinux.org/pub/qslinux/ with complete source tar files. Do I have to
> down load one of these?
>
>          Thanks for the help.
>
>          Conn
>
> At 05:27 PM 10/23/00 -0500, you wrote:
> >Hello Conn,
> >
> >I wrote a nice little I/O control subsystem for the MPC850.  It is in
> >QSLinux (http://qslinux.org, ftp::/qslinux.org), and is in the
> >subdirectories snmc/qslinux/kernel and snmc/qspin.
> >
> >The subsystem gives you the ability to check, request, and configure the
> >function of the I/O pins on the MPC850.  It is modeled after the I/O
> >address allocator for the 80x86 architecture.  You can access the
> >subsystem either from kernel space, or from a user space program.
> >
> >You will need to modify the subsystem for operation with other MPC8xx
> >processor (i.e. the MPC860 has more I/O pins). But this should not be
> >difficult.
> >
> >I don't have a command-line driven program that interfaces to the
> >subsystem, but if you write one and are willing to share it I would love
> >to have a copy :-).
> >
> >Regards,
> >Daris
> >
> >
> >clark@esteem.com wrote:
> > >
> > > Hello everyone,
> > >  my stuff blah blah blah
> > >
> >
> >--
> >Daris A Nevil
> >Simple Network Magic Corporation
> >401 Kentucky Lane
> >McKinney, TX 75069
> >214-793-7757
> >dnevil@snmc.com
> >www.snmc.com
> >quickstack.com
> >qslinux.org
>
> *****************************************************************
>    If you live at home long enough, your parrents will move out.
> *****************************************************************
>
> Conn Clark
> Engineering Stooge                              clark@esteem.com
> Electronic Systems Technology Inc.              www.esteem.com
>
> Stock Ticker Symbol                             ELST
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
