To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem with compiling ppcboot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Jul 2004 05:19:49 PDT."
             <20040729121949.23526.qmail@web13603.mail.yahoo.com>
Date: Thu, 29 Jul 2004 19:09:16 +0200
Message-Id: <20040729170921.BDA6CC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040729121949.23526.qmail@web13603.mail.yahoo.com> you wrote:
>
>          Im working with MPC8245 EncorePP1 board..
> in this when compile ppcboot with make command..

This is your first error. PPCboot is a dead project. Development  was
discontinued nearly two years ago. Please use U-Boot instead.

> it is showing errors as follows...
...
> ppc-elf-gcc -D__ASSEMBLY__ -g  -Os
...
> ppc-elf-gcc: installation problem, cannot exec `cpp0':

You are obviously using a home-grown toolchain which has at least  an
installation  problem.  Either  fix  your toolchain, or use a working
one.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is undignified for a woman to play servant to a man who is not
hers.
	-- Spock, "Amok Time", stardate 3372.7

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
