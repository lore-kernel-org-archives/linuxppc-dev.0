To: ssx761221 <ssx761221@sina.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: what 's Kernel stack overflow? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Aug 2002 21:20:13 +0800."
             <20020808132013.14581.qmail@sina.com>
Date: Thu, 08 Aug 2002 21:23:07 +0200
Message-Id: <20020808192312.5A49810DE1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <20020808132013.14581.qmail@sina.com> you wrote:
>
> which is downloaded at denx's ftp.  we have ported qt-embedded-free-3.0.5.
> "hello" demo works well at first, but  it died after running about one hour.
> Not only that demo but also the whole system .
>   messages like this:
...
> Call backtrace:
> 00000000 C00025DC 00000148 0F847D60 0F67A4E4 0F67A3F0 0F67A7E0
> 0F847C58 0F67B13C 0F847DC0 0F656364 0F65F6E0 100049B8 10005ECC
> 0FBE7E9C 0FBE7DAC 0FAF1A2C 0FC05064 0FBA4250 0FBA4048 0FB209D4
> 0FB1EE1C 0FBA5A5C 0FB1EA34 10003C84 0F626DBC 00000000
> Kernel stack overflow in process c1ad8000, r1=c1ad8450

It would be very interesting to know where in the kernel you crashed,
so decodint this call backtrace is something I highly recommend.

>  what's the meaning of "kernel stack overflow"

Lierally: you overflowed the kernel's stack.

>  memory leak?

or excessive dynamic memory use (large  arrays  as  automatic  data),
deep recursion, etc.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Until you walk a mile in another man's moccasins, you  can't  imagine
the smell.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
