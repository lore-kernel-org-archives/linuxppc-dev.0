Message-ID: <B164B53F5BD6D511888D009027732E1A4D11CC@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem setting breakpoints with BDI2000
Date: Tue, 21 May 2002 12:38:01 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I have BDI2000 with software version v1.11
I have problems setting a breakpoint. I am trying to set a breakpoint in the
start_kernel() function to debug misbehaving kernel.
So, at command line I type:
bi 0xXXXXXXXX, where 0xXXXXXXXX is address of start_kernel out of map file.
BDI does not stop there, it passes this breakpoint. IO tried it with HARD
and SOFT breakpoints.

I know that my kernel gets into infinite loop in timer interrupt. So I put a
breakpoint there -- same! Nothing happens.

I tried to connect to BDI with DDD. I can successfully load the kernel and
start the kernel. When it freezes, I can halt BDI2000 and single step the
kernel. I can now use breakpoints freely -- all works.
Basically, if I start kernel, BDI does not react to any of the breakpoints.
It starts to react on them once it was stopped at least once.

Any help is greatly appreciated,
Thanks,



/************************/
Rudolf Ladyzhenskii
DSP Engineer
Advanced Communication Technologies
ph.  +61 3 8080 8215
fax. +61 3 9672 8800
Level 9, 341 Queen Street,
Melbourne, 3000
Australia
/***********************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
