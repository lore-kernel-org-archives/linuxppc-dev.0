Message-ID: <1068545269.3fb0b4f5c72e5@pop-mail.india.tejasnetworks.com>
Date: Tue, 11 Nov 2003 15:37:49 +0530
From: Anil Giri <anil@india.tejasnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: anil@india.tejasnetworks.com
Subject: SDRAM mirroring problem
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  My board uses SAMSUNG K4S511632M SDRAM in 8M * 16 bit * 4 banks configuration
(13 rows & 10 columns).Two such chips are used to get 128 MB and uses CS1 for
chip select.My board uses MPC852T processor.

MPC to SDRAM configuration is as follows:
======================
A29 :A0
A28 :A1
A27 :A2
A26 :A3
A25 :A4
A24 :A5
A23 :A6
A22 :A7
A21 :A8
A20 :A9
GPL_A0 : A10
A18 :A11
A17 :A12

A6 :BA0
A5 :BA1
GPL_A3 :CAS
GPL_A2 :RAS
GPL_A5 :WE
=====================
My problem is that when i write some word in first RAM chip is mirrored
in the other RAM chip.And Effectivly i m able to use only 64 MB of RAM.
What could be the problem???
Following SDRAM settings are used

IMMR:0xff000000
OR1: 0xf8000e00
BR1: 0x00000081
MSTAT:0x00000400
MAMR: 0x80a06114
MAR: 0x88
MCR:0x80002105

Thanks in advance...
-Anil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
