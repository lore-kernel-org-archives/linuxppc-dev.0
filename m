Message-ID: <3AC8C4F0.9C009A91@mvista.com>
Date: Mon, 02 Apr 2001 11:29:04 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc-2.2.2
References: <3AC8743B.8BC64EA5@opensource.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:
>
> Hi all,
>
> Anyone tried glibc-2.2.2?

yep.  we found it crashes in the dynamic loader on a cache instruction
during a memset for loading the second dynamic library. since libc is
always the first library loaded any application that only uses libc
works. any app that uses more than libc, seg faults.

> It cross-compiles cleanly, but acts wierd on my mpc8xx target.
>
> I've browsed through my old 2.1.3 patches for the cacheline-
> size and I'm not sure if everything is ok with 2.2.2...
>

we are working it as I type.   my guess is the cacheline patches didn't
make it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
