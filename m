To: "Flavio Pereira" <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on 8260 using ELDK..Help?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Sep 2002 10:20:44 +0200."
             <1E354700654661418593A0D6B5A9D41008943F@mail.azisa.co.za>
Date: Thu, 05 Sep 2002 10:43:30 +0200
Message-Id: <20020905084335.DBFAA11836@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1E354700654661418593A0D6B5A9D41008943F@mail.azisa.co.za> you wrote:
>
> I have returned to the original uart.c. Although it still kills my
> serial port it has nothing to do with the unable to open initial
> console. Will the original uart.c I still get logging in

Since your console _uses_ the serial port, this HAS something  to  do
with each other.

> uart.c is probably something that I will still have to look at, but it
> is not the root cause of my original problem. Any more suggestions would
> be appreciated since I feel I've hit the brick wall quite severely now.
> Besides file permissions (which Im conviced are fine now) what else
> could cause the kernel to not be able to open a console?

Maybe you did not initialize one, or you put it on an  unitialized  /
non-working port.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you're not part of the solution, you're part of the problem.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
