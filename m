Message-ID: <3AC49B9B.DB935E85@inn.ericsson.se>
Date: Fri, 30 Mar 2001 16:43:39 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: =?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Whate kind of kernel errors cause an Segmentation Fault
References: <EADB10BAC266A14A85ECBF8686A73E310A9127@kolkrabbi.flaga.is>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


No segmentation fault is sent as signal 11 it's not a return value.

Happens when the program uses memory it dose not own.

Kári Davíðsson wrote:
>
> EFAULT i believe
>
> check linux/include/asm/errno.h
>
> K.D.
>
> > -----Original Message-----
> > From: Ralph Blach [mailto:rcblach@raleigh.ibm.com]
> > Sent: 30. mars 2001 14:19
> > To: Embedded Linux list
> > Subject: Whate kind of kernel errors cause an Segmentation Fault
> >
> >
> > What kind of kernel return codes will cause the C library to print out
> > the message
> >
> > "Segmentation Fault"
> >
> > Thanks
> >
> > Chip
> >
>

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
