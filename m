Message-ID: <007201c0339d$5b235c60$0a00010a@airvent.it>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA on the FADS
Date: Wed, 11 Oct 2000 18:05:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to make the Damm's PCMCIA socket drivers work on my FADS823.

I think the problem is related to the ioremapping of _IO_BASE.

What value should i give to it? I tried giving it an unused value
(0x02200000 on my FADS), doing into arch/ppc/mm/init.c a simple
ioremap(_IO_BASE, _IO_BASE_SIZE) where IO_BASE_SIZE is 64*1024, but when i
load m8xx_pcmcia.o i get this error:

8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
8xx_pcmcia: FADS using SLOT_B with IRQ 13.
IP: C400B0AC XER: A000624E and so on.....
TASK = c0640000[17] 'insmod' mm->pgd c032f000

What is the problem? :-o

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
