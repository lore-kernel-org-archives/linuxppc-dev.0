To: emanuel stiebler <emu@ecubics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 2.1.0, kernel 2.4.21, MPC8245, ntpd 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Aug 2003 12:40:23 MDT."
             <3F426F17.3090206@ecubics.com>
Date: Tue, 19 Aug 2003 21:04:58 +0200
Message-Id: <20030819190503.EA35FC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Emanuel,

in message <3F426F17.3090206@ecubics.com> you wrote:
>
> I get a "Segmentation fault (core dumped)" on my system using ntpd.

This is caused by some (I2C based RTC's in "11 minute mode".

> I checked the archives, and there is one messeage about something like
> this on a 405.
>
> Is anybody working on this ? Did I missed some patches ?

We fixed this by making this mode configurable  (and  disable  it  by
default) in our version of the linuxppc_2_4_devel tree; the patch was
added on May 29, so just "cvs update" your source tree.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A complex system that works is invariably found to have evolved from
a simple system that worked."             - John Gall, _Systemantics_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
