Message-ID: <20010214100858.15856.qmail@dag.newtech.fi>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Porting framework ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Feb 2001 12:08:58 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

As I  just fairly successfully have ported the a Linux
kernel (2.2.17) to a PPC board, I would like to make
some suggestions:

1. What about putting our "clever" heads together
and creating a framework for porting Linux to
a PPC board.
  - Splitting up the  code for the Mac:s to make it work wo.
   Open Firmware, or creating a stub's file for usage in
   the embedded ports. Now it is fairly difficult to use ie.
   the PCI-code in 2.4.x wo. the OF stuff, at least it needs
   some duplicated work.

2. Then documenting this fairly well.... Some kind of
  PPC porting guide ?
3. Making an effort in commenting the code we have already done.
4. Doing a centralized administration for this and getting
  it into Linus's main branch.

Is this going on already or should we do something about
it ?.

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
