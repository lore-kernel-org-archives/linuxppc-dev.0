Message-Id: <200003312105.XAA13716@denx.local.net>
To: Naushit Sakarvadia <naushit@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiler for Sun sparc2.7 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 31 Mar 2000 12:47:14 -0800."
             <20000331204714.28878.qmail@web701.mail.yahoo.com>
Date: Fri, 31 Mar 2000 23:05:58 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20000331204714.28878.qmail@web701.mail.yahoo.com> you wrote:
>
> Anyone knows, where can I get precompiled cross compliner + binutils and glibc for SUN platform?
> any help will be highly appreciated.

Ummm... "Sun platform" is not really clear. Are you running Linux  on
it? :-)

The subject says "sparc2.7" which I'll interpret as Sun SPARC running
Solaris 2.7. Is that what you mean?

I have a set ot Makefiles and patches that will build the full  cross
development  kit  (binutils, GCC, glibc) plus zlib+sash under Solaris
2.6; I guess this will work under  Solaris  2.7,  too,  but  I  never
tested.

Just drop me a note if you're interested.

NOTE: The tools on my web  page  http://www.denx.de/solutions-en.html
are  an  older version and will not build under Solaris. I would like
to get some more testing done (especially under Redhat 6.x on  Sparc)
before posting a newer release.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Not one hundred percent efficient, of course ... but nothing ever is.
	-- Kirk, "Metamorphosis", stardate 3219.8

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
