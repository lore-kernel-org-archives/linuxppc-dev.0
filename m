Message-ID: <6DF87017DA95D611AC6000606730DE9B0EC0CC@BLREXSR>
From: Nageswari S <nageswari@sanyo.co.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: USB Host Controller Problem
Date: Thu, 14 Nov 2002 12:52:56 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a custom PowerPC baord based on IBM 405 core with "No PCI".

I have my USB Host controller (OHCI) based with HC registers from
0xef601200.

When I access these address locations, I am getting kernel panic with
machine check interuupt.

Is there any special setting to enable IO address range.

Any help or suggestion will be very helpful...

Thank you,
Regards,
Nageswari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
