Subject: RE: Going to sleep atomically
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 8 Mar 2001 20:51:11 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3108AFBC@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Embedded Linux list" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oooops.
Sorry for the confusion.

I stand corrected.

K.D.

> -----Original Message-----
> From: Roland Dreier [mailto:roland@topspincom.com]
> Sent: 8. mars 2001 16:42
> To: Embedded Linux list
> Cc: Kári Davíðsson
> Subject: Re: Going to sleep atomically
>
>
>
>     KD> Like in blocking read() and poll() etc?
>     KD> interruptable_sleep_on() or sleep_on()
>
> No!!  Do _not_ use sleep_on() in new code.  It isn't atomic (there is
> a race condition where you will miss the wakeup).  In an earlier post
> to this mailing list
> (<http://lists.linuxppc.org/listarcs/linuxppc-embedded/200102/
> msg00093.html>)
> I gave the following good advice:
>
>     You really don't want to use sleep_on() any more (Linus wants to
>     remove it for 2.5).  Take a look at
>
>     <http://lwn.net/2001/0201/a/sleep-fix.php3>
>
>     for a safer way to sleep, or use the wait_event macro (in
>     linux/sched.h).
>
> Roland
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
