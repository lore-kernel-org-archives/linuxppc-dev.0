To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Feb 2003 05:47:35 PST."
             <995FF289C9D69747A09E42992644595405B23683@penguin.adic.com>
Date: Mon, 24 Feb 2003 22:15:43 +0100
Message-Id: <20030224211548.0DA99C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <995FF289C9D69747A09E42992644595405B23683@penguin.adic.com> you wrote:
>
> - I presume RTAI and subsequently any task running on top of it are running
>   in user mode, as opposed to kernel mode?

Wrong. The real-time part of RTAI applications usually runs in kernel
mode; it may (but  does  not  have  to)  communicate  with  user-land
applications.

> - Would it be possible, using the RTAI, to receive inbound data encapsulated
>   in some storage protocal via the associate device driver, pass this about
>   a few RTAI tasks, and then ship it out encapsualted in another storage
>   protocal envelope via the associate device driver ... all the time using
>   the same buffer of I/O data (i.e. no buffer to buffer copies)??

Sure.

> Given our need to prevent buffer copies of I/O data, I was envisioning
> implementing a good part of our application as kernel treads. This is why I
> was looking into the preemption patch, and also why Real-Time abastraction
> layers that sit on top of the kernel were not showing up on my radar.

RTAI does not sit on top of linux, it's rather vice versa: Linux sits
on top of the RTAI "real-time kernel".

F'up to <rtai@rtai.org> ?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If a train station is a place where a train stops,
                                           then what's a workstation?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
