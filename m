Message-ID: <20010127081108.10265.qmail@dag.newtech.fi>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Does th sym53c8xx driver really work on PPC ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 27 Jan 2001 10:11:08 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

just got my very own port of Linux to a PPC
going, but are having problems with the SCSI.
It uses a Symbios 53c875 chip and works fine
if I disable the "Special features" by booting
with sym53c8xx=specf:n, but if I keep these on
there are problems downloading the scripts and
the driver loops with an "Illegal instruction in the
SCRIPT "error.

The thing is that the SCRIPT seems to be written
directly to a region that is ioremap():ed from the
address read from the PCI-config for the RAM.
This cannot possibly be right ?
This address is the local PCI bus address and the
address seen from the PPC will have an offset for
the PCI window, in my case 0xc0000000.

So my questions are:

1. Does ths above reasoning sound OK to you ?
2. Is there anyone that have seen this working with the
  stock 2.2.18 (also tried ths 2.2.14) kernel ?

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
