To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Jun 2002 08:32:55 PDT."
             <20020617153255.GS13541@opus.bloom.county>
Date: Mon, 17 Jun 2002 19:25:05 +0200
Message-Id: <20020617172510.22BB1102FB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020617153255.GS13541@opus.bloom.county> Tom Rini wrote:
>
> Yes, we should.  Patches vs linuxppc-2.5 (note, you won't be able to
> boot 8xx unless you perform some other updates) happily accepted.

Tom, I'm a bit frustrated.

You know that I've sent this very same patch to you a long, long time
ago. At a time, when there wasn't even a 2.5 around.


You shouldbe aware of all the problems with 2.5 for 8xx systems -  is
the  only  way  to  get  ANY  patches  into the _working_ tree really
through 2.5? Why must we  go  through  the  pain  to  fix  a  lot  of
unrelated problems in a tree we don't really care about (yet) just to
fix things?

This policy is just nonsense.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I can call spirits from the vasty deep."
"Why so can I, or so can any man; but will they come when you do call
for them?"          - Shakespeare, 1 King Henry IV, Act III, Scene I.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
