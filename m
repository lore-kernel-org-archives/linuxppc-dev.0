To: Alban Wood <awood@bloodwolf.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx fpu emu 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Sep 2002 15:38:48 EDT."
             <Pine.LNX.4.44.0209111537420.1731-100000@manoir.bloodwolf.org>
Date: Wed, 11 Sep 2002 23:49:49 +0200
Message-Id: <20020911214954.582F0FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.44.0209111537420.1731-100000@manoir.bloodwolf.org> you wrote:
>
> I forgot to mention that I was able to verify that the floating point
> emulator *works*. I examined the result of a floating point division in
> memory and it was valid. So I guess it is the libc I am using. Like I
> said, could it be that it was compiled with -msoft-float?

You are right: the whole ELDK environment for the 8xx  (and  for  the
4xx, btw.) uses -msoft-float.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Beware of bugs in the above code; I have only proved it correct, not
tried it."                                             - Donald Knuth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
