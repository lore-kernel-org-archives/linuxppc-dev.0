Date: Thu, 28 Aug 2003 13:25:27 +0200
Message-ID: <3F39F7430002E6F2@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <1062060226.25974.5.camel@toni>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: K-computing RTAI benchmark cross-compile
To: t.vanremortel@ha.be,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-- Original Message --
>Subject: K-computing RTAI benchmark cross-compile
>From: Toni Van Remortel <t.vanremortel@ha.be>
>Reply-To: t.vanremortel@ha.be
>To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
>Date: Thu, 28 Aug 2003 10:43:47 +0200
>
>
>
>Hi all,
>
>I'm trying to cross-compile the benchmark for RTAI, made by K-computing,
>to ppc (EP405 board with IBM PPC 405GP cpu).
>I use the ELDK compiler-set (which is working perfect, I compiled kernel
>and rtai with it without any problem).
>
>But when I try to compile the benchmark, I get these errors:
>
>ppc_4xx-gcc -O -Wall -c timer_test.c
>/tmp/ccUWN8MR.s: Assembler messages:
>/tmp/ccUWN8MR.s:136: Error: Unrecognized opcode: `pushl'
>/tmp/ccUWN8MR.s:137: Error: Unrecognized opcode: `pushl'
>/tmp/ccUWN8MR.s:138: Error: Unrecognized opcode: `rdtsc'
>/tmp/ccUWN8MR.s:139: Error: Unrecognized opcode: `movl'
>/tmp/ccUWN8MR.s:140: Error: Unrecognized opcode: `movl'
>/tmp/ccUWN8MR.s:141: Error: Unrecognized opcode: `popl'
>/tmp/ccUWN8MR.s:142: Error: Unrecognized opcode: `popl'
>/tmp/ccUWN8MR.s:351: Error: Unrecognized opcode: `pushl'
>/tmp/ccUWN8MR.s:352: Error: Unrecognized opcode: `pushl'
>/tmp/ccUWN8MR.s:353: Error: Unrecognized opcode: `rdtsc'
>/tmp/ccUWN8MR.s:354: Error: Unrecognized opcode: `movl'
>/tmp/ccUWN8MR.s:355: Error: Unrecognized opcode: `movl'
>/tmp/ccUWN8MR.s:356: Error: Unrecognized opcode: `popl'
>/tmp/ccUWN8MR.s:357: Error: Unrecognized opcode: `popl'
>make: *** [timer_test.o] Fout 1
>
>I assume it's some problem with wrong functions or so, but I really
>don't know where to look.
>
>PS: The RTAI-dir and Linux-dir are correclty changed in the Makefile.
>
>Anybody a clue how to solve this? Or are there other PPC RTAI benchmarks
>available?

The program seems to use x86 asm instructions somehow. Is timer_test.c
a user space program or a kernel module? Where can I download it from?

Hope it helps.

Wolfgang.

Wolfgang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
