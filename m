Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EBA0BAE.93167851@prodys.net>
Date: Thu, 08 May 2003 09:47:58 +0200
From: Pedro Parrilla <pparrilla@prodys.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Rx problems with IDMA on MPC860...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Hi,

    I'm working on a MPC860T. I've been trying to receive from a
peripheral via IDMA and it seems to work OK, but when I study data
received from IDMA I can see that there are some bytes at the end of
each IDMA buffer received that are wrong, in fact they haven't been
written to the buffer and previous bytes remain; but interrupts are
received Ok, and the number of read bytes in the peripheral are the IDMA
set.

    It could be an access problem to the peripheral with IDMA(without
IDMA this access is totally OK!).

    Does anybody have any experience in this regard?


    Thank you in advance.

    ---------------------------------------------

 Pedro Parrilla Jimena                           Prodys.S.L
 Embedded Systems Programming     Trigo,54
 e-mail pparrilla@prodys.net              Leganes(Madrid) 28914
 Tel.:+34916896880                               http://www.prodys.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
