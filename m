From: Philip.Lougher@zarlink.com
Subject: TDM (E1) transport over ATM AAL1
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF6D4A5F50.C8C31CB5-ON80256C68.00531151@zarlink.com>
Date: Tue, 5 Nov 2002 15:10:05 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Um, it's rather difficult to say without knowing *anything* about your
hardware.  Embedded PowerPC cores vary considerably in performance between
models/make.  You also don't mention how many interrupts you expect per
second - is there going to be an interrupt per ATM cell?

Phillip

----- Forwarded by Philip Lougher/Zarlink on 05/11/2002 15:17 -----

                      Robert Douglas
                      <rdouglas15@yahoo.com>                 To:       linuxppc-embedded@lists.linuxppc.org
                      Sent by:                               cc:
                      owner-linuxppc-embedded@lists.l        Subject:  TDM (E1) transport over ATM AAL1
                      inuxppc.org


                      05-Nov-2002 01:59 PM







Hi, I am starting to develop a project for TDM
transport (E1 at 2048k bits/sec) over ATM AAL1 using
embedded linux on PowerPC.
This application is defined in the ATM FORUM
specification 'af-vtoa-0078.000' (Circuit Emulation
Service Interoperability Specification)
I would like to know if anyone has experienced this
kind of application.
I am worried about the PowerPC performance, it would
have to route about 5.5k ATM AAL1 cells/sec, and the
adaptative clock recovery method.

Regards,
Robert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
