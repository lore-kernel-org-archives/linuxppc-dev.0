To: "Jeremy Rosen" <Rosen.Jeremy@tms-pty.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory requirements 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Oct 2001 13:41:17 +1100."
             <sbcc391b.064@tms-pty.com>
Date: Tue, 16 Oct 2001 08:52:17 +0200
Message-Id: <20011016065222.39FEE10889@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <sbcc391b.064@tms-pty.com> you wrote:
>
> Hello everybody, I am trying to put a Linux on a FADS860T board, and I
> have no idea of the quantity of memory I will need....

This depends on your application, and which functions you  need  from
the kernel.

> could anyone give me an idea of minimal and reasonable memory
> requirement for these kind of boards...

Minimum for a running system with very small application:
	1MB flash, 4 MB RAM.
Medium configuration as used in many shipping products like ISDN
routers, Bluetooth Lan Access Points, etc.:
	2 MB flash, 8 MB RAM
Comfortable system for development (sufficient to compile the Linux
kernel native on the target):
	4 MB flash, 16 MB RAM

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one instruction - from which, by induction, one can deduce that every
program can be reduced to one instruction which doesn't work.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
