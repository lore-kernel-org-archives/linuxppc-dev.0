To: t.vanremortel@ha.be
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: K-computing RTAI benchmark cross-compile 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 28 Aug 2003 10:43:47 +0200."
             <1062060226.25974.5.camel@toni>
Date: Thu, 28 Aug 2003 11:07:28 +0200
Message-Id: <20030828090733.6F9D3C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Toni,

in message <1062060226.25974.5.camel@toni> you wrote:
>
> I'm trying to cross-compile the benchmark for RTAI, made by K-computing,
> to ppc (EP405 board with IBM PPC 405GP cpu).

I don't know this benchmakr (URL  ?),  but  judging  from  the  error
messages:

> ppc_4xx-gcc -O -Wall -c timer_test.c
> /tmp/ccUWN8MR.s: Assembler messages:
> /tmp/ccUWN8MR.s:136: Error: Unrecognized opcode: `pushl'
> /tmp/ccUWN8MR.s:137: Error: Unrecognized opcode: `pushl'
> /tmp/ccUWN8MR.s:138: Error: Unrecognized opcode: `rdtsc'
...

...I  guess  that  this  source  file   contains   inline   assembler
instructions, which are NOT meant for a PowerPC processor.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Behind every great man, there is a woman -- urging him on.
	-- Harry Mudd, "I, Mudd", stardate 4513.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
