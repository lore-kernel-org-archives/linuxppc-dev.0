To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: installing ncurses for cross compiling 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 08 Mar 2003 01:24:58 +0530."
             <3E68F912.7000602@tataelxsi.co.in>
Date: Fri, 07 Mar 2003 21:30:24 +0100
Message-Id: <20030307203029.335B2C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E68F912.7000602@tataelxsi.co.in> you wrote:
>
> I want to write some programs for our serial console using ncurses. I
> have written and tested the apps in i386, now I want to cross compile it.
> I ahave Monta vista linux and ncurses is not available on i386.

You can find cross-development  versions  of  the  ncurses-devel  and
ncurses RPM's as part of our ELDK, see http://www.denx.de/re/ELDK.html


Note that you must install the cross development environment,  i.  e.
it will not work to use just these 2 RPM's with a native compiler.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If I don't document something, it's usually either for a good reason,
or a bad reason.  In this case it's a good reason.  :-)
                 - Larry Wall in <1992Jan17.005405.16806@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
