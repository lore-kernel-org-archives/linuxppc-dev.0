Date: Wed, 10 Dec 2003 15:43:41 +0100
Message-ID: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: 405 TLB miss reduction
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

we are suffering from TLB misses on a 405GP processor, eating up to
10% of the CPU power when running our (rather big) application. We
can regain a few percent by using the kernel option CONFIG_PIN_TLB
but we are thinking about further kernel modifications to reduce
TLB misses. What comes into my mind is:

 - using a kernel PAGE_SIZE of 8KB (instead of 4KB).
 - using large-page TLB entries.

Has anybody already investigated the effort or benefit of such
changes or knows about other (simple) measures (apart from
replacing the hardware)?

TIA.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
