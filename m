Date: Mon, 20 Jan 2003 10:59:21 -0500
From: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: VGA out/External Monitor on ibook 2
Message-ID: <20030120155921.GA22300@haar.ae.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

	I know this has been asked before, but I did not come across any
solutions, so let me appologise if I missed them.

I have a: ibook 2 (white ibook from summer of 2001) 500MHz. It has a ATI
Rage 128 graphics card which my OF calls ATY,RageM3p29s. The aty128fb
module is used for video framebuffer, and I can't seem to get VGA mirror
to work.

case 1: Monitor connected at boot up
The external monitor is fine at depth 8, resolution 1024x768-8@60Hz.
Changing the depth (text mode) with fbset makes the font look like the
wrong depth. It feels like font depth has changed but not the display
depth. The internal-LCD display stays just fine.

case 2: Monitor not connected at boot up
The external monitor is "wavy". I turn the LCD off (m3mirror from benh)
and play around with timings, resolutions etc. The "waviness" gets more or
less but I could not find setting to make it stable. BTW, it is true for
both a CRT and flat-panel. Internal-LCD is fine (at 1024x768).


Has this been solved? If not, how can I help?

Regards,
manuj

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
