Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCF0C@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: enet rx doesn't work
Date: Tue, 12 Mar 2002 10:42:22 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've tried to use the enet over the LXT905. Tx seems to work, but I'm not able
to receive data from it.
I've measured the rxd, rclk and rena pins (the RENA signal is aktive high), but
they seems to be ok too.

But I get no rx interrupt, the scc_enet_interrupt is never called when receiving
data.

I'm using kernel 2.4.4 from denx.

Any ideas?

Martin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
