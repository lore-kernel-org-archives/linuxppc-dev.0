Message-ID: <3B36700C.B775FB54@mvista.com>
Date: Sun, 24 Jun 2001 18:56:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <SNijsure@SkyStream.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SCC1 on 860 Ethernet, PortA TxD (PA14) setting.
References: <B25E2E5A003CD311B61E00902778AF2A026376D8@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:

> Why should TXD be set as input  instead of output?

When a pin is not configured as a general purpose output (as is the
case here), the other registers become special configuration registers
for that specific use.  Or, stated another way, the direction bits
only imply direction when the pin is configured for GPIO.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
