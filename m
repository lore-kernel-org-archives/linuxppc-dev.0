Message-ID: <3DD0FB07.D624FC40@imc-berlin.de>
Date: Tue, 12 Nov 2002 13:58:47 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK 2.0, glibc and kernel 2.4.20???
References: <3DB4BE6200027CEE@mss3n.bluewin.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >Hi guys, Hi Wolfgang,
> >
> >I am using ELDK 1.0 for development. Thanks for that great tool chain!
> >
> >Now I want to switch from 1.0 to version 2.
> >
> >Do I have to rebuild the glibc comming with the ELDK 2.0 to use it with
> a
> >2.4.19/20 kernel instead of the 2.4.4 that comes with this kit?
>
> This is normally not necessary. So far we have not realized any problems
>
> with 2.4.19 kernels. BTW: it´s the same dilemma with ELDK 1.0.
>

I know. I did once. And I don't want to do it again! :o)

Let's say I want to use the O_DIRECT feature with files. Of course O_DIRECT is
not defined in 2.4.4 but in 2.4.19.

So would it be enough to define the flag O_DIRECT in my application?
Since all that glibc does is passing the flags to the kernel while opening a
file, doesn't it?

Cheers,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
