To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Dec 2001 09:49:37 EST."
             <3C0CE281.2E0F451C@seranoa.com>
Date: Tue, 04 Dec 2001 16:25:14 +0100
Message-Id: <20011204152519.1778BF9C0@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Andrew,

in message <3C0CE281.2E0F451C@seranoa.com> you wrote:
>
> Yes that is the start of Flash.  For our final product we want our
> bootloader to live in Flash but I'm rethinking that for the EST board.
> From what I've read on the list is sounds like PPCBoot wants to live in
> ROM on the sbc8260 right?

No. The default configuration installs in the 4 MB  SIMM  flash;  you
can change the configuration to install in the onboard flash.

> Is the above documented anywhere?  I don't feel the need to reinvent the
> wheel for this board and I'd rather start off the right way.

Well, the config file for the SBC8260 is pretty well  documented.  If
anything is not clear, ask me or on the ppcboot-users mailing list.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How many seconds are there in a year? If I tell you there are 3.155 x
10^7, you won't even try to remember it. On the other hand, who could
forget that, to within half a percent, pi seconds is  a  nanocentury.
                                               -- Tom Duff, Bell Labs

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
