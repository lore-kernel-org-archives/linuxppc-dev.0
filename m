Subject: Re: K-computing RTAI benchmark cross-compile
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Wolfgang Denk <wd@denx.de>
Cc: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Ralph Blach <rblach@intrex.net>
In-Reply-To: <20030828090733.6F9D3C59E4@atlas.denx.de>
References: <20030828090733.6F9D3C59E4@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1062071306.25974.14.camel@toni>
Mime-Version: 1.0
Date: Thu, 28 Aug 2003 13:48:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I reply once to all 3 replies from:
Wolfgang Denk
Wolfgang Grandegger
Ralph Blach

I only quote the message from Wolfgang Denk.

Op do 28-08-2003, om 11:07 schreef Wolfgang Denk:
> Dear Toni,
>
> in message <1062060226.25974.5.camel@toni> you wrote:
> >
> > I'm trying to cross-compile the benchmark for RTAI, made by K-computing,
> > to ppc (EP405 board with IBM PPC 405GP cpu).
>
> I don't know this benchmakr (URL  ?),

http://www.kcomputing.com/benchmark/
It is mentioned by an article on LinuxDevices.com
(http://www.linuxdevices.com/articles/AT6320079446.html)

> but  judging  from  the  error messages:
>
> > ppc_4xx-gcc -O -Wall -c timer_test.c
> > /tmp/ccUWN8MR.s: Assembler messages:
> > /tmp/ccUWN8MR.s:136: Error: Unrecognized opcode: `pushl'
> > /tmp/ccUWN8MR.s:137: Error: Unrecognized opcode: `pushl'
> > /tmp/ccUWN8MR.s:138: Error: Unrecognized opcode: `rdtsc'
> ...
>
> ...I  guess  that  this  source  file   contains   inline   assembler
> instructions, which are NOT meant for a PowerPC processor.

As far as my C-knowledge goes, I don't see any explicit assembler code
in this file. But I might be wrong.

As I could see, the benchmark is written for x86 (well, if you take a
look at the Makefile, you might suspect it). I hoped it would
cross-compile.

If there are other benchmarks for RTAI on PPC, please tell me. It saves
me some work (on the very tight schedule I have these days).

Thank you all.

Regards,
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
