To: "Elan Feingold" <elan@nxnetworks.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux 2.4.4 on 860 custom board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 24 Aug 2001 15:46:07 CDT."
             <NDBBLJKOJGKDOFBHNPGEMEIICEAA.elan@nxnetworks.com>
Date: Fri, 24 Aug 2001 22:59:41 +0200
Message-Id: <20010824205946.A14DA11265@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NDBBLJKOJGKDOFBHNPGEMEIICEAA.elan@nxnetworks.com> you wrote:
>
> I'd have no problem.  The IMMR is at the right place (0xff000000), and in
> general the kernel boots up fine, but it dies with a "kernel access of bad
> area" where the actual address is question is usually strange (e.g.
...

Ummm...

> I'd usually think it was a memory timing setup problem, right?  But VxWorks

Maybe, but I don't think so here.

> runs fine, and has for years on the board.

For years? Which mask revision is your CPU, then? Did you enable  the
CPU6  bug  workaround  in  the kernel configuration for a try, and/or
disabled the data cache?

> Any ideas?  Is it possible that VxWorks just has less strict timing
> requirements to run?

Probably it does not use the MMU as much.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Life, loathe it or ignore it, you can't like it."
- Marvin the paranoid android

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
