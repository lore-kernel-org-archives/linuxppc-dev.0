Message-ID: <400D38A9.9060003@jonmasters.org>
Date: Tue, 20 Jan 2004 14:18:17 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: hagit guy <hagit_guy@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IRQ mask
References: <Sea2-F4v67qeFlBwXPa0002b3be@hotmail.com>
In-Reply-To: <Sea2-F4v67qeFlBwXPa0002b3be@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hagit guy wrote:

> I need to mask IRQ4 and interrupt on PC0. Does Linux do it at startup?

Unless you register a device on that IRQ it will be thrown away as a bad
interrupt when your device starts generating random interrupts.

See register_irq and similar.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
