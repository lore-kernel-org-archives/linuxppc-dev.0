Message-ID: <3B37AEEC.80402@mvista.com>
Date: Mon, 25 Jun 2001 14:36:44 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@ibmoto.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: software FP support?
References: <Pine.GSO.4.05.10106251633130.22421-100000@softail.somerset.sps.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our (montavista) toolchain is built with softfloat.  Btw, our 2.0
Journeyman release is available on our ftp site (includes glibc-2.2.3).
  start with our website to find out how to download it.
http://www.mvista.com

Kumar Gala wrote:

> I was wondering what the current state of software floating point support
> was in the PowerPC embedded world.
>
> I am trying to build a glibc with soft-fp to get a /bin/sh that does not
> setup the fpu state.  I was wondering if someone has already gone through
> this trouble or how people have been handling this.
>
> I know that the kernel has support for soft-fp handling which would allow
> userland and libc to still use FP code but that seems expensive.
>
> Any information would be helpful.
>
> thanks
>
>  - kumar
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
