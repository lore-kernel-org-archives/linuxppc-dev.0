To: lihong wei <lihongwlh@yahoo.com>
Cc: ppclinux <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: Serial console failure on DENX Linux on MPC850 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Dec 2003 10:49:27 PST."
             <20031219184927.4885.qmail@web41901.mail.yahoo.com>
Date: Fri, 19 Dec 2003 21:39:48 +0100
Message-Id: <20031219203953.4BEA6C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031219184927.4885.qmail@web41901.mail.yahoo.com> you wrote:
>
> I just found out that the serial driver only call
> rs_init, rs_write, instead of calling rs_8xx_init(),
> etc. I just download the latest develop source from
> denx. Its serial driver seems to be very inchoate. I

Ummm... it's working perfectly fine here.

> am trying to fix this. Any help will be appreciated!

What exactly are you complaining about,  and  what  problem  are  you
tring to fix?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every solution breeds new problems.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
