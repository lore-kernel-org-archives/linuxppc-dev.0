To: Richard Danter <richard.danter@windriver.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 750/107 CHRP question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 01 Aug 2003 10:02:46 BST."
             <3F2A2CB6.4030104@windriver.com>
Date: Fri, 01 Aug 2003 14:17:35 +0200
Message-Id: <20030801121740.1D9ADC602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Richard,

in message <3F2A2CB6.4030104@windriver.com> you wrote:
>
> > My understanding is that more than just a static  mapping  is  needed
> > for full MMUP support.
>
> You are correct. Only the kernel and drivers statically linked can be
> easily debugged. It could be possible to debug modules but since the
> addresses change every time you load them it would not be practical. You
> would have to edit the symbol files (*.ab) each time.

Thanks for confirming this.

> For complete MMU handling the debugger would need to know where to find
> the mapping tables and remap it's symbol info. None of our debuggers can
> do that yet.

Are there any plans to add such support?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Intuition, however illogical, is recognized as a command prerogative.
	-- Kirk, "Obsession", stardate 3620.7

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
