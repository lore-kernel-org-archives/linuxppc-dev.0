Date: Fri, 8 Nov 2002 00:29:04 -0600 (CST)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200211080629.gA86T4s56329@sullivan.realtime.net>
To: Alban.Fellows@blueyonder.co.uk
Subject: Re: USBHID Problem
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marcello has reversed a change to drivers/usb/hid-input.c because it was
broken.   It will be in -rc2, or you can undo the change yourself
(line 274 order of operands to find_next_zero_bits).

milton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
