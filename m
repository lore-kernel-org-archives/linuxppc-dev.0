To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Jun 2002 14:43:39 PDT."
             <20020617214339.GZ13541@opus.bloom.county>
Date: Tue, 18 Jun 2002 00:28:07 +0200
Message-Id: <20020617222812.3CCC0102FB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tom,

in message <20020617214339.GZ13541@opus.bloom.county> you wrote:
>
> likely) for 2.4 and 2.5.  And yes, an untested/lightly tested 2.5 patch
> is perfectly acceptible.  2.5 itself is only lightly tested (or not
> tested at all for some cases).

But don't you see  the  problem?  Exactly  this  is  what  makes  2.5
unusable: it's a collection of lightly or not tested patches.

> I'm asking you (and everyone else) to submit new work for the community
> vs 2.5 before you submit it for 2.4.  This has the bonus that the next
> stable release will have all of your fixes in it already and you won't

I don't see any bonus, but I do see  additional  (and  most  probably
wasted) efford.


Tom, let's stop here. I understand _what_ you say, and even parts  of
the _why_, but it's not practical to me.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
After a time, you may find that "having" is not so pleasing a thing,
after all, as "wanting."  It is not logical, but it is often true.
	-- Spock, "Amok Time", stardate 3372.7

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
