To: jtm@smoothsmoothie.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Feb 2001 08:34:27 CST."
             <20010222083427.A21811@shamus.smoothsmoothie.com>
Date: Thu, 22 Feb 2001 16:02:16 +0100
Message-Id: <20010222150221.92B50281D9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010222083427.A21811@shamus.smoothsmoothie.com> you wrote:
>
> > It  seems  you  forgot  to  modify   the   "bd_info"   structure   in
> > "include/asm-ppc/est8260.h""  to  match  the  definition as passed by
> > PPCBoot.
>
> You were right. I went back and checked, and I missed a line when
> I copied from ppcboot.h to est8260.h.

So now it's working for you? Congrats!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In theory, there is no difference between  theory  and  practice.  In
practice, however, there is.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
