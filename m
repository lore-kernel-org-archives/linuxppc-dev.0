Message-ID: <3AD7F303.FAD9EA51@opersys.com>
Date: Sat, 14 Apr 2001 02:49:39 -0400
From: Karim Yaghmour <karym@opersys.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Samuel Rydh <samuel@ibrium.se>, linuxppc-dev@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] gettimeofday stability
References: <Pine.HPX.4.10.10104121947440.1891-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> Given that time handling is completely different in 2.2 and 2.4, it is
> surprising. This would indicate that a decrementer interrupt has happened
> too early.
>
> How often does it happen ? Does it still happen with recent kernels ?
> Were you running something that touches the decrementer (MOL, RTLINUX) ?
>

I can't tell you if the interrupt is happening too early or not,
although code could be added to check this.

I can tell you that this has been noticed by more than one person.
I noticed this and so did the person at MontaVista that contributed
the cross-platform reading code (to enable traces to be read accross
different endian machines).

If you really want to see what I mean I could forward you a textual
trace sample to proove my point.

The latest kernel I've tested this on is 2.4.0-test10.

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
