To: =?ISO-8859-1?Q?S=E9bastien_C=F4t=E9?= <scote1@matrox.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Progress - new problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Feb 2001 16:19:31 EST."
             <20010209161931.A30585@dyn-52-73.matrox.com>
Date: Fri, 09 Feb 2001 23:11:00 +0100
Message-Id: <20010209221105.4CE2C28161@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010209161931.A30585@dyn-52-73.matrox.com> you wrote:
>
> I progressed quite a bit since my last e-mail... I put back KERNELBASE +
> PAGE_OFFSET + KERNELLOAD to 0xc0000000 even though it complicates debugging
> quite a bit.  Now, the kernel goes through create_elf_tables without a

Oops? Why do you think this makes debugging more complicated? I don't
care where something is mapped, it's  the  job  of  the  debugger  to
resolve those addresses, isn't it?

> Board is similar to Sandpoint, processor is 7400 running in little-endian.
                                                              ^^^^^^^^^^^^^^
							      ^^^^^^^^^^^^^^

Are you really trying to run in little-endian mode? Really???
You are not supposed to do that.

> P.S.:  What do you guys use for debugging?  Is there any debugger out there
> that does address translation (from MMU) to see what instruction gets
> executed when you're at a virtual address?

We use the Abatron BD2000; it supports the MMU, interfaces to  GDB  /
DDD,  comes  with  3  years  of warranty on the hardware, _excellent_
support from the Abatron folks, and is cheaper than  other  solutions
(2500 Euro).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
