Message-ID: <004101c087a4$58994580$a66d34c0@oleane.com>
From: "Lionel TAILLURAT" <Lionel.TAILLURAT@ecrin.com>
To: "ppc_mailing_list" <linuxppc-embedded@lists.linuxppc.org>
Subject: MVME 23xx VME drivers problems
Date: Fri, 26 Jan 2001 15:29:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm using a debian PPC 2.2 with 2.2.17 kernel.

1/
I'm trying to patch this kernel with the Gabriel Paubert's 2600 VME patch
(for 2.2.12 kernel).
I have some failures like :

patching file `linux/arch/ppc/kernel/ppc_ksyms.c'
...
Hunk #1 FAILED at 48.
Hunk #2 FAILED at 212.
...

Is there is a way to patch the 2.2.17 kernel or must I use 2.2.12 ?

2/
I'm trying to use the vmelinux driver ( www.vmelinux.org) it compiles well,
but when I install it I have the message :

ca91c042.o: init_module: Device or resource busy
Hint: this error can be caused by incorrect module parameters, including
invalid IO or IRQ parameters

and error output gives to me :

  Tundra Universe PCI-VME Bridge Driver 1.0 00Oct3
  Copyright 1997-2000, Michael J. Wyrick
  Universe device found.  Vendor = 10E3  Device = 0000  Status = 02000007
  Class = 00068000
  Misc0 = 00000000
  Read via mapping, PCI_ID = FFFFFFFF
  Universe Chip Failed to Return PCI_ID in Memory Map.

What is the problem ?

3/

Finally I'm trying the universe driver
 http://lisa2.physik.uni-bonn.de/~hannappe/software/ ).

It need bigphyarea (which is not available for 2.2.17 kernel) to make DMA
transfers.

And when I make a cat /dev/vme_stat it returns to me only 0xFFFFFFFF or 0X0
values :
...
VME Register image enabled at VME-Address 0xFFFFFFFF
...

What's wrong ?


Lionel

-------------------------------------------------------
Lionel TAILLURAT
TECHNICAL SERVICE

ECRIN AUTOMATISMES -industrial computer's-
Rue du pré-de-l'Horme
B.P 15
38921 CROLLES CEDEX
FRANCE
Tel :(33) 4 76 92 20 01
Fax :(33) 4 76 08 03 18
Email: Lionel.TAILLURAT@ecrin.com
Email: support@ecrin.com
---------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
