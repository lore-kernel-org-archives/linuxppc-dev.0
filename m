Message-ID: <0A0CCED2EF0FD41196950060089FDFED1A5E92@nt0.omnibyte.com>
From: Don Easton <dhe@omnibyte.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial console driver question
Date: Thu, 6 Feb 2003 11:11:16 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm new to the list as of yesterday, and new to Linux as of a
couple of weeks ago. I've tried researching this on the net
but haven't come up with anything, so I'm asking for help here.

I'm trying to port Linux to a custom VME board we make, this
board doesn't have any video or keyboard hardware, so I need to
use the onboard serial port as a terminal console. It looks
to me like everybody uses a 16550 UART compatible device for
serial ports, but we happen to have a Zilog z85230 part on our board.
So my question becomes; what's the best/easiest way to get Linux
to talk to this part and use it as the consol? Being new to all this,
I'm not sure if I should try to patch the kernel, or write a driver
for this part, or something else... Any advice would be appreciated.

TIA,

Don Easton
Omnibyte Corp.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
