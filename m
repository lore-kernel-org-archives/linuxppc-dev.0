Message-ID: <3A1291D5.71286AA7@agelectronics.co.uk>
Date: Wed, 15 Nov 2000 13:38:29 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: dink32 downloads
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anybody got a reliable recipe for downloading code over the serial
port to a Sandpoint running dink32 (version 12, rev 0)? I'd prefer to do
it from Linux, but right now I'd accept NT.

I've so far tried minicom, cu, and hyperterminal. Minicom claims to
upload a 100k ascii file in <1 second. cu takes about the right time,
but dink32 eventually starts reading the s-records as commands.
Hyperterminal simply becomes unresponsive when I try to send an ascii
file.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
