MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Whate kind of kernel errors cause an Segmentation Fault
Date: Fri, 30 Mar 2001 14:54:35 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3108B011@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well he asked what kind of kernel error causes segfault.
If I am not wrong returning EFAULT, e.g. from driver causes
the kernel to send signal 11 (SIGSEGV) to the application
which has default signal handler that causes the application
to crash.

K.D.

> -----Original Message-----
> From: Kenneth Johansson [mailto:kenneth.johansson@inn.ericsson.se]
> Sent: 30. mars 2001 14:44
> To: Kári Davíðsson
> Cc: Embedded Linux list
> Subject: Re: Whate kind of kernel errors cause an Segmentation Fault
>
>
> No segmentation fault is sent as signal 11 it's not a return value.
>
> Happens when the program uses memory it dose not own.
>
> Kári Davíðsson wrote:
> >
> > EFAULT i believe
> >
> > check linux/include/asm/errno.h
> >
> > K.D.
> >
> > > -----Original Message-----
> > > From: Ralph Blach [mailto:rcblach@raleigh.ibm.com]
> > > Sent: 30. mars 2001 14:19
> > > To: Embedded Linux list
> > > Subject: Whate kind of kernel errors cause an Segmentation Fault
> > >
> > >
> > > What kind of kernel return codes will cause the C library
> to print out
> > > the message
> > >
> > > "Segmentation Fault"
> > >
> > > Thanks
> > >
> > > Chip
> > >
> >
>
> --
> Kenneth Johansson
> Ericsson Business Innovation AB   Tel: +46 8 404 71 83
> Viderögatan 3                     Fax: +46 8 404 72 72
> 164 80 Stockholm                  kenneth.johansson@inn.ericsson.se
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
