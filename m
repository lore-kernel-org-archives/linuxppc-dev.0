Message-ID: <006201c1bf2d$4b637f90$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Christian Pellegrin" <chri@infis.univ.trieste.it>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.44.0202261423220.23446-100000@sole.infis.univ.trieste.it>
Subject: Re: execve system call question
Date: Wed, 27 Feb 2002 10:23:00 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Cristian Pellegrin!

I tried the 'hello world' thing.
but it didn't worked.

Thank you for the reply.

----- Original Message -----
From: "Christian Pellegrin" <chri@infis.univ.trieste.it>
To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, February 26, 2002 10:27 PM
Subject: Re: execve system call question


> On Tue, 26 Feb 2002, Sangmoon Kim wrote:
>
> >
> > and /opt/hardhat/devkit/ppc/7xx/target for NFS root.
>
> > VFS: Mounted root (nfs filesystem).
> >
> > Is there any method to debug this?
> > I'm debugging it for a month.
> >
>
> I'll suggest:
>
> 1) turn on debugging on the nfs server
>
> 2) generate a trivial hello world program and put it instead of
> /sbin/init. So to be sure it's a ppc executable. Start with a static
> linked one,it's a bit difficult to do dynamic linking right at the first
> time ;-)
>
> Bye!
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
