To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Opps...with ELDK-2.1.0 (ppc_4xx) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Apr 2003 08:49:54 CDT."
             <F9102D41F595D311ACA7009027DE2C840527B19B@c3po.heurikon.com>
Date: Wed, 23 Apr 2003 19:14:56 +0200
Message-Id: <20030423171501.96FD2C5E29@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <F9102D41F595D311ACA7009027DE2C840527B19B@c3po.heurikon.com> you wrote:
>
> i2c is somewhat slow...and I looked at the driver to see it using spin_lock() around the write to the rtc. This could potentially be the problem...and it most likely would not be observed with a memory mapped rtc device (because it is much faster than i2c).


Ummm... can you please try using shorter lines? Some 70...80 chars or
so? Thanks.

> I just changed spin_lock() to spin_lock_irq() and I'm currently testing it.
>
> Wolfgang:  Is the driver that you're seeing the problem with using spin_lock().

No, it is not. We see the problem for example  on  the  LWMON  board,
which uses drivers/char/pcf8563_rtc.c and drivers/i2c/i2c-simple.c.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I'm what passes for a Unix guru in my office. This is  a  frightening
concept. - Lee Ann Goldstein, in <3k55ba$c43@butch.lmsc.lockheed.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
