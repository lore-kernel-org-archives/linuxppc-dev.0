Message-Id: <200310060645.BAA09508@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-15"
From: "J.Murali" <j.murali@gdatech.co.in>
Reply-To: j.murali@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: cfi probe for two different flash devices
Date: Mon, 6 Oct 2003 12:20:53 +0600
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all,

i am working on a custom board(Redwood6) using IBM ppc 405. I am using
the Montavista's kernel 2.4.17. We have one AMD flash of 4 MB and one
Intel flash of 16 MB on our board. There are 4 mtd partitions are in AMD
and Intel flash is used as storage space of 5 mtd partition.

AMD partitions
-----------------
1. Bootparams
2. Bootldr
3. kernel
4. Filesystem1

Intel partition
--------------
5. Filesystem2

In the CFI probe, the kernel detects only one flash either AMD or INTEL
(Which address we specify as window address). What i have to to do for
cfi to detect both flash devices.

Any suggestions are appreciated

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
