Date: Sun, 28 Jul 2002 09:26:18 -0700 (PDT)
From: Alex Papazoglou <papazoga@reed.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: iBook Modem Audio
Message-ID: <Pine.GSO.4.33.0207280902310.6339-100000@oberon.reed.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This message is directed at people working with (new) iBooks.

When a dialout command is issued to the iBooks internal modem and the
modem's "volume" (ATMx) is non-zero, the modem begins transmitting call
progress digital audio over the serial link. I'm wondering if anybody has
any information on the format of the stream. I have managed to get
something approximating the expected sound by using sox with a
sampling rate of 8000 using some logarithmic 16-bit encoding (or maybe 8
bits at around 16000?), so I'm reasonably confident that getting call
progress sound for your iBook2 is doable. Unfortunately, I know nothing
about sound encoding.

Anybody know more about this?

Alex Papazoglou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
