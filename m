To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: console on SCC1 on 8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Apr 2002 14:01:28 +0200."
             <3CC7F018.2040604@dgt-lab.com.pl>
Date: Thu, 25 Apr 2002 15:15:23 +0200
Message-Id: <20020425131528.51108FF65@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CC7F018.2040604@dgt-lab.com.pl> you wrote:
>
> Huh, I've just discovered that arch/ppc/8260_io/uart.c does not support
>  console on SCC1!
> Anyone has such version of this driver?

In all such situation just try the version on our FTP server :-)

For instance, the CPU86 configuration uses SCC1 for console.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
One essential to success is that you desire be an all-obsessing  one,
your thoughts and aims be co-ordinated, and your energy be concentra-
ted and applied without letup.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
