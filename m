To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8260: ncurses -> keypad() failing. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Jul 2003 12:47:52 +0530."
             <3F0A7020.6030205@tataelxsi.co.in>
Date: Tue, 08 Jul 2003 12:23:44 +0200
Message-Id: <20030708102349.660E4C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F0A7020.6030205@tataelxsi.co.in> you wrote:
>
> When I issue the call keypad(), it returns failure (ERR).
> I don't know what the error is. it does not set errno, so I cannot use
> perror().

And we don't know which versions of the [n]curses libraries  you  are
using,  and  where  you got them from or how they were configured and
built.

And I haven't seen any test code in your posting.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: can't find /

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
