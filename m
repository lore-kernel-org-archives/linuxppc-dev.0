Date: Tue, 7 Mar 2000 22:32:38 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.15pre11 on PB Lombard
In-Reply-To: <200003070559.XAA13652@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1000307220928.20594A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

has anyone got the latest kernel from paulus's stable tree running on
a 1999 powerbook? It panicks invariably after hda and hcd are initialized.
xmon tells the following:

Floppy drive(s): fd0 is 2.88M
Machine check in kernel mode (regsat c03fdd90)
caused by (from srr1): Unknown udm in srr1
                               ^^^<- not sure about this bit, my handwriting
                                     really leaves to be improved...:(

NIP: C00D0D54 XER:20000000 LR: C00D0D30 REGS: 03fdd90 TRAP: 0200
MSR: 00009030 [EEIRDRME]
TASK=c03fc000[1] 'swapper' mm->pdg c0162000 last syscall:120

... some 2^4 adresses or so follow, which I could write down if anyone
will find them useful. I can't get anything beyond that, because xmon
prints everything else black on black!

This happens both with CONFIG_MAC_FLOPPY set or unset (the above is without
floppy driver)

Grateful for any pointers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
