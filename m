Message-ID: <20021024201830.21273.qmail@web14602.mail.yahoo.com>
Date: Thu, 24 Oct 2002 13:18:30 -0700 (PDT)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: PPC 405 port complains about 'tlbwe' opcode
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi There,

I am in the process of porting linux-2.4.18 with
ppc-patch-2.4.18 to make a 405 linux os. For 'make
bzImage' it complains about 'tlbwe' being Unrecognied
opcode from head_4xx.S.

-------
powerpc-eabi-gcc -D__ASSEMBLY__ -D__KERNEL__
-I/root/ppctest/linux/include -c -o head_4xx.o
head_4xx.S
head_4xx.S: Assember messages:
head_4xx.S:111: Error: Unrecognized opcode: `tlbwe`
head_4xx.S:112: Error: Unrecognized opcode: `tlbwe`
make[1]: *** [head_4xx.o] Error 1
-------

I saw couple of postings saying that 'tlbwe' is not a
405 opcode. But it is defined by PPC-405 manual. I am
not sure what WS value should be, if i have to add
'tlbwe' to supported opcodes.

Please suggest. If you can share a PPC-405 port for
linux or any other embedded free OS, please let me
know.

thanks in advance,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
