To: "Smith, Craig" <Craig.Smith@icn.siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Dynamic lib loading & memory question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Jun 2004 14:58:55 PDT."
             <EA78B62757AF1E4799828249310AC4CA04E09F03@stca206a.bus.sc.rolm.com>
Date: Fri, 25 Jun 2004 00:39:20 +0200
Message-Id: <20040624223925.6E67FC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Craig,

in message <EA78B62757AF1E4799828249310AC4CA04E09F03@stca206a.bus.sc.rolm.com> you wrote:
>
> I have a simple hello world program I'm trying to compile and run on a
> custom PPC(855T) board. It will work fine if I statically link the
> executable with the necessary libs. However if I don't statically link
> (relying on ld.so etc.), the program will core dump. My system has 16M of
> SDRAM (I just upgraded it from 8M and I believe it's configured right).
> Anyway, here's the output and other info that might help someone tell me
> what I'm doing wrong...thanks so much!

Which type of board is this, which boot loader  are  you  using,  and
where is your toolchain coming from?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A Perl script is correct if it's halfway readable and  gets  the  job
done before your boss fires you.
                       - L. Wall & R. L. Schwartz, _Programming Perl_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
