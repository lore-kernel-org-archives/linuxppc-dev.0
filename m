Date: Fri, 21 Sep 2001 17:12:43 -0400
From: macdonldc@netscape.net (Craig MacDonald)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Console Bug in linux-2.4.4 for sbc8260
Message-ID: <4E54C6E5.53244AA2.031B03A1@netscape.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I finally got linux to boot and display messages on
the serial console.

The problem was that in immap_8260.h

immap_t *immr;

was not extern and code in uart.c was getting a
garbage value for immr. I changed it to

extern immap_t *immr;

and I not receive console messages.

Best,
Craig MacDonald


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
