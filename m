Message-Id: <200101301446.f0UEkTO10556@denx.local.net>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initial stack frame 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Jan 2001 08:26:45 EST."
             <4.3.2.20010130074919.00bb0a80@falcon.si.com>
Date: Tue, 30 Jan 2001 15:46:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.3.2.20010130074919.00bb0a80@falcon.si.com>
Jerry Van Baren wrote:
>
> One of the differences between the ABI and EABI is that the EABI
> requires 8 byte alignment of the stack and the ABI requires 16 byte
> alignment (EABI, p.28).

Yes, ok. But what is implemented by GCC and glibc? The SVR4 ABI or
the EABI?

In other words: Wolfgang Grandegger wants to know if  we  must  align
"private" stack frames on 8 or 16 byte boundaries...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
