To: "sanjay k k" <fren00@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc_405-gdb + Segmentation fault (core dumped) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "18 Sep 2002 01:31:37 -0000."
             <20020918013137.15713.qmail@webmail6.rediffmail.com>
Date: Wed, 18 Sep 2002 08:59:07 +0200
Message-Id: <20020918065912.45817FA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020918013137.15713.qmail@webmail6.rediffmail.com> you wrote:
>
> I was trying to debug the kernel with the help of BDI, but
> couldn't do so as gdb is dying itself.
> I am using monta vista cross-compiled gdb. Here what i do to debug
> the kernel.

You need a newer version of GDB. The one included in  our  ELDK  will
work. See http://www.denx.de/re/ELDK.html

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Life is a garment we continuously alter, but which  never  seems  to
fit."                                                  - David McCord

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
