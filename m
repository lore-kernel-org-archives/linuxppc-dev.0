Date: 1 Nov 2001 10:13:02 -0000
Message-ID: <20011101101302.15843.qmail@mailweb11.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: "OpenPIC versus EPIC" in MPC8240 !
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear reader,
 I am trying to enable interrupts on the sandpoint X2
board hosting MPC8240, in Mode 1.

I decided to use OPenPIC code (openpic.c) for EPIC,
as the  MPC8240 manual claims that EPIC is an OpenPIC standard. But I find some disparities between  the way EPIC's registers are organised and the way OpenPIC data
structures are declared.( openpic_defs.h )

According the OpenPIC data structure,
 "OpenPIC_Source" resides at offset 0x50000
 whereas the EPIC ( section 11 of MPC8240 manual)
says the it resides at 0x50200 ( See page 11-5)
 So, there is absolutely no gaurantee that
openPIC code would work for EPIC, Am i right ?

One more, If some1 could give me a clear picture
of interrupt routing on sandpoint board, it would
be very useful.
  From what i read, I have understood the following
Please correct me if I am wrong.

 1. The INTA ( used by Function  0 of Winbond -
    PCI/ISA bridge) is connected to IRQ0 of EPIC.

 2. The PCI interrupts (INTx) are  connected to the
    remaining PINs of EPIC in some order. ( I dont
    know which order they are connected )

Any help would be appreciated. Meanwhile, I am
reading the sandpoint manual also..( This one, I add
inorder to avoid replies like "RTFM")

Thanks for any help guys

Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
