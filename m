Message-ID: <399BD14B.1EB38043@dgt-lab.com.pl>
Date: Thu, 17 Aug 2000 13:49:31 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: too few RAM?
References: <00Jun4.144038est.115228@border.alcanet.com.au>
			 <393BBE5D.49B17E9C@embeddededge.com> <00Jun6.135659est.115272@border.alcanet.com.au> <39929A9C.C17E22D7@dgt-lab.com.pl> <3992C0ED.E66C42FF@embeddededge.com>
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Wojciech Kromer wrote:
> >
> > i'm trying to run  mpc8xx-2.2.13 (with all patches I found)
> >  - with 8xxrom (0.3.0)
> >  - on MPC8XXFADS
> >     .MPC823e
> >     .4MB RAM
> >     .2MB FLASH
>
> Yes, sorry, this is too little RAM.  A long time ago in a land
> far, far away (before initrd support), you could boot in less than 8
> Mbytes.  Not any more.
>
>         -- Dan
>


now i have 8MB RAM,but my kernel still hangs trying to run any
application

my kernel is: 'Using ELF interpreter /lib/ld.so.1'

i was trying to compile ld.so, but there are erros:
lddstub.S:19: #error Only know how to support i386, m68k and sparc
architectures
lddstub.S:36: #error Only know how to support i386, m68k and sparc
architectures

ld.so... versions from net dosent semm to work
(i was trying to use one from HHL, and from mbxroot.min.tgz file)

Q1: where can i get FULL BINARY versions of:
 -8xxrom (or something like this)
 -kernel starting from nfs
 -root file system (to put it on nfs server)
form my board


Q2: are there any source packages for ALL what i need to re-compile


--
* * * * * * * * * * * * *
* per pedes ad astra !  *
* * * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
