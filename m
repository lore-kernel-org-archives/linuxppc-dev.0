Date: Sat, 23 Jun 2001 06:58:33 -0700
From: Matt Porter <mporter@mvista.com>
To: amyyah@china.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pins sequence
Message-ID: <20010623065833.B4239@cx258813-a.chnd1.az.home.com>
References: <EH989377818989.03519@mail3.china.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EH989377818989.03519@mail3.china.com>; from amyyah@china.com on Fri, Jun 22, 2001 at 06:10:10PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 22, 2001 at 06:10:10PM +0800, amyyah@china.com wrote:
> Hello.I use MCPN750 CPU-Board.And there's serial port(COM1,8 pin) on
> its front panel. How can I turn it into normal RS232 connector
> (9 pin)? What's the pins sequence?

RTFM

MCPN750 CompactPCI Single Board Computer Installation and Use, July 2000
Page 4-17

Pin	Signal
--------------
1	DCD
2	RTS
3	GND
4	TXD
5	RXD
6	GND
7	CTS
8	DTR

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
