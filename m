To: "Juan Padron" <j_padron@joseane.zzn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash programing 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Nov 2001 10:09:59 +0100."
             <5BFFEE450E4C9264CB2CB0E906D67860@j_padron.joseane.zzn.com>
Date: Mon, 12 Nov 2001 11:39:01 +0100
Message-Id: <20011112103906.D72F710DD9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5BFFEE450E4C9264CB2CB0E906D67860@j_padron.joseane.zzn.com> you wrote:
>
>  We have Metrowerks CodeWarrior (for Windows). It has a little application and we use it to program the flash (via the Wigglers BDM): write and erase.

OK.

> But now, we are starting with embedded linux and we want to know how we can program the flash fron Linux using the BDM.

You question is not clear.

Of course you can use your BDM tool to write a Linux image  to  flash
memory.

You won't be able to do much Linux debugging with  it  since  (AFAIK)
the CodeWarrior does not understand about the MMU.


You can also write the flash memory  from  Linux,  using  appropriate
Linux  device  drivers;  we  have  a simple one in our version of the
Linux kernel, or you can use the MTD layer.


If you are looking for a BDM tool that fit's into the Linux toolchain
I strongly recommend the BDI2000:

- it has MMU support
- it has a simple telnet interface that can be used for things like
  automatic image download (simple "expect" scripts will do)
- it speaks GDB remote protocol so it can be easily used with standard
  Linux tools like GDB or DDD.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is easier to change the specification to fit the program than vice
versa.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
