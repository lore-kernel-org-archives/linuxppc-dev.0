To: diekema@bucks.si.com (diekema_jon)
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: HOWTO: Creating a root file system < 32 MB 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 31 Aug 2001 08:38:55 EDT."
             <m15cnZX-001SysC@bucks>
Date: Fri, 31 Aug 2001 15:18:47 +0200
Message-Id: <20010831131852.91AFB10CC0@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon,

in message <m15cnZX-001SysC@bucks> you wrote:
>
> Objective:
>     Create a Linux root file system that is under 32MB for a MPC8260 target.

Ummm... 32 MB? That's HUGE!!! Most of the systems I see  in  products
have root filesystems in the size of 2...8 MB.

> Direction:
...
>     board.  We will start with all the packages in HHL 1.2, and
>     removed the fluff until we hit our target size.

I  disagree  with  this  method  in  general.  Taking  any  "standard
distribution" and removing things will always be a poor way to design
an   embedded   system.   You  will  always  get  caught  in  strange
interdependencies, where you cannot remove A (which you don't  need),
because  it's  needed  for  some  function of B (which you also don't
need), but another function of B is used by C, which is important  to
you.

If you want to build a lean system you have to do it  the  other  way
round: bottom up.

See also: .sig below :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
