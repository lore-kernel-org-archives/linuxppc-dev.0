Message-ID: <3EA66C39.70B34B50@cdotd.ernet.in>
Date: Wed, 23 Apr 2003 04:34:33 -0600
From: Rahul Dev <rahuld@cdotd.ernet.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: stack and .bss of bootprom code
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

      I  am porting  linux2.4  over my  own  custom board (powerpc
8260).
 I have  got my own boot prom code that provides support for debugging
 and loading  of  kernel.

 My ram is mapped at address 0x00000000 and its size is 128MB.
 I m using  KERNELBASE  as 0xc0000000.

 The problem is that i m not able to decide where should i keep the
stack and
 .bss  areas of  my bootprom code in RAM??

  Also,  what should be the value of  bi_memsize  in  m8260_setup.c
file?

  thanx in advance for any  help.

  regards,
  -rd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
