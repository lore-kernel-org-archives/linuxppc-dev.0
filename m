Message-ID: <3BE13832.C2209860@raleigh.ibm.com>
Date: Thu, 01 Nov 2001 06:55:30 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Serial Port 0 IRQ0 Walnut question
References: <15326.8355.242681.874353@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anybody noticed that the serial port 0 is not being interrupt
driven.
On my Journeyman kernel here, IRQ 0 lists as bad and the UIC enable bit
for IRQ 0 is not
turned on.

Any reason for this

Thanks

Chip

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
