To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx IDE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Feb 2002 12:41:07 +0100."
             <3C7A22D3.80905@dgt-lab.com.pl>
Date: Mon, 25 Feb 2002 14:24:30 +0100
Message-Id: <20020225132435.70C5D109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C7A22D3.80905@dgt-lab.com.pl> you wrote:
>
> >  EXT_DIRECT is used for IDE devices directly connected to the 8xx
> >             bus using some glue logic, but _not_ the 8xx internal
> >             PCMCIA interface (example: IDIF860 systems)
> >...
> What does it mean 'some glue logic'? I have to use CompactFlash on 8260. How to connect it?

I think Steven Scholz <steven.scholz@imc-berlin.de> posted some
schematics some time ago. If you can't find it, try contacting
Steven.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can do this in a number of ways.     IBM chose to do all of them.
Why do you find that funny?        -- D. Taylor, Computer Science 350

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
