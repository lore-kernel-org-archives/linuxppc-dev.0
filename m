To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel from denx vs. bitkeeper 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Feb 2003 12:55:13 PST."
             <995FF289C9D69747A09E42992644595405B2367F@penguin.adic.com>
Date: Sat, 22 Feb 2003 21:19:01 +0100
Message-Id: <20030222201906.E598CC6E0D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Brian,

in message <995FF289C9D69747A09E42992644595405B2367F@penguin.adic.com> you wrote:
>
> How do you manage CVS and bk together? In other words, how do you pull
> bitkeeper updates into your CVS controlled source tree?

Simply:  I  don't.  I  tried  several  ways,  but  probably  I  don't
understand  enough of BK to make it work reliably. So I just generate
patches between certain BK versions, which I  then  import  into  our
CVS.

> However, I ran a test to make sure this would work and ran into a problem.
> This is what I tested:

I tried similar things, and always  ran  into  some  cases  where  an
automatic approach would fail.

> Any words of wisdom??

Sorry, I'm neither a BK nor a CVS guru (but I manage  to  do  my  job
with CVS).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Faith may be defined briefly as an illogical belief in the  occurence
of the improbable.                                    - H. L. Mencken

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
