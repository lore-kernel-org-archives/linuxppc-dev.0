From: Ton van den Broek <tvdbroek@tsc.leica.nl>
Reply-To: tvdbroek@tsc.leica.nl
To: linuxppc-embedded@lists.linuxppc.org
Subject: ttyS1 on an MVME5100
Date: Thu, 29 Apr 2004 16:54:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404291654.22823.tvdbroek@tsc.leica.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody

does somebody ever uses the second serial channel on a Motorola MVME5100?
Are there any known problems?
When I want to write() a string  the CPU-activity LED burns green, and nothing
else happens. The whole Linux stops responding, probably because it is
polling some bit(s) in kernel-space.
When I open ttyS0 I see my string appearing on the debug-channel, no problems
there.
I'm using Linux version 2.4.7-timesys-3.1.246 from Timesys. Since this is a
free download there is no support from them.

Thanks for any feedback
Ton van den Broek
Software engineer
Leica Microsystems Lithography
Best, NL.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
