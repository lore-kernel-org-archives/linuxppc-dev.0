Message-ID: <A109131318C4D1119AC20060088DECE330F4B1@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: Patrick Lerda <Lerda@microprocess.com>, "'Dan Malek'" <dan@netx4.com>,
        Nguyen Xuan Hoang <hoang_nguyen@op.com.sg>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MMU problems?
Date: Thu, 22 Jun 2000 08:44:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I agree. I believe we ARE dealing with a kernel bug, and it is particular to
the MPC823.

Let's hear some success stories--embedded units in production, running in
the field for days, shutting down power and rebooting with no kernel panics.
That may help convince me we are dealing with a hardware issue.


Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.


-----Original Message-----
From: Patrick Lerda [mailto:Lerda@microprocess.com]
Sent: Thursday, June 22, 2000 2:01 AM
To: 'Dan Malek'; Nguyen Xuan Hoang
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MMU problems?



Have you tried to do complex operation on a 8xx board like compiling the
kernel. This operation
works well on a PPC740 board, but on a 8xx after a long time the kernel goes
in an unstable
state. Theses bugs are related to the 8xx MMU code.

Patrick LERDA

> -----Message d'origine-----
> De:	Dan Malek [SMTP:dan@netx4.com]
> Date:	jeudi 22 juin 2000 05:56
> À:	Nguyen Xuan Hoang
> Cc:	linuxppc-embedded@lists.linuxppc.org
> Objet:	Re: MMU problems?
>
>
> Nguyen Xuan Hoang wrote:
>
> > I have seen a lot of discussions about MMU on MPC823,
>
>
> There are no MMU or cache related problems on any of the MPC8xx
> processors and stable versions of Linux.  These are just people
> discussing the challenges of building custom boards and making
> source code changes.
>
> There are dozens of people shipping products with Linux running on
> these processors.  You seldom hear from people that are happy and
> successful.
>
>
> 	-- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
