Message-ID: <3A7ADEDF.FC5008D3@mvista.com>
Date: Fri, 02 Feb 2001 11:22:55 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Konstantin Sabodash <konstantin.sabodash@fnc.fujitsu.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC2 as console on 8260
References: <3A78C148.F1F2579A@fnc.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Konstantin Sabodash wrote:

> I set  in "arch/ppc/8260_io/uart.c"
> #define CONFIG_SERIAL_CONSOLE_PORT 2
> Is it enough to to make SCC2 main console?

No. The current 8260 uart.c driver is in pretty bad shape.  I started
making some changes to support exactly what you are asking for, but
didn't yet finish.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
