Message-ID: <3DD83DB8.5090600@gmx.de>
Date: Mon, 18 Nov 2002 09:09:12 +0800
From: Michael Habermann <mhabermann@gmx.de>
MIME-Version: 1.0
To: John Traill <john.traill@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc-2.5 / Sandpoint X2
References: <3DD4E4D3.4030805@motorola.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Traill wrote:

> However I'm not sure if this is indicative of an error in the changes
> above or just the fact that the kernel isn't doing
> anything else but service irq's.

Check the switch S5, which changes the IRQ polarity. Maybe the interrupt
line is always asserted.
On a 8240 CPU, it needs reversed polarity.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
