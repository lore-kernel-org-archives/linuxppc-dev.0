Message-ID: <3C2C9215.65A76EB@c-s.fr>
Date: Fri, 28 Dec 2001 16:39:02 +0100
From: "LEROY Christophe" <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Oops when receiving a lot of UDP packets while booting
References: <3C2C84A2.51B8D952@c-s.fr> <3C2C8CC1.E2A99B19@chinook.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What is HHL2.0 ?
I'm using the official 2.4.16 kernel from kernel.org with the ppc ports
patch for 2.4.15.
I'm not using FEC but MC68160A (that is enet.c). But that's probably the
same problem.
Any idea how to solve the problem ?

C.Leroy

Peter Desnoyers a écrit :

> You're using HHL2.0?  There's a bug in fec.c where it will pass packets
> up the stack too early in initialization.  The tcp stack doesn't take
> too kindly to this, as a number of data structures which are assumed to
> exist by the code are actually null pointers at this point in time...
>
> --
> .....................................................................
>  Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
>  Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
>  100 Hayden Ave, Lexington MA 02421


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
