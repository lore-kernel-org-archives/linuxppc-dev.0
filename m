To: "vandana mehtani" <vandana_mehtani123@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org, Sukesh.Acharya@siritech.com
Subject: Re: problem when compiling gcc for pwerpc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "05 Jun 2002 09:15:27 -0000."
             <20020605091527.20240.qmail@webmail9.rediffmail.com>
Date: Wed, 05 Jun 2002 12:14:22 +0200
Message-Id: <20020605101427.01343102F2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Vandana,

in message <20020605091527.20240.qmail@webmail9.rediffmail.com> you wrote:
>
> i am trying to make a crosscompiler for powerpc using the option
> powerpc-linux...

Why don't you just use existing, working tools?  Our  Embedded  Linux
Development  Kit  is  free for download, just us it. It also includes
instructions how to rebuild  from  prstine  source  files  if  you're
really in the mood to do so. See http://www.denx.de/ELDK/

> when i was trying to configure gcc for powerpc with the following
> command
> usr/src/gcc/gcc-2.96-20000731/configure --target=ppc-linux

You're heading for trouble anyway.  GCC  2.96  was  never  officially
released.  It  is a known fact that it cannot be used for instance to
compile a Linux kernel. Even if you manage to build it, you will  not
have much fun using it.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Real programmers don't comment their code. It was hard to  write,  it
should be hard to understand.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
