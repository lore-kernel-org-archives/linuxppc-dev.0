To: Dmitriy.Zavin@infineon.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC2 and SCC3 serial ports on RPX Classic (MPC860) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2003 11:17:18 PST."
             <FD90897E35ABD311AE0E0008C7E6404A07192EDE@ca02exch4.sjc.infineon.com>
Date: Wed, 26 Mar 2003 22:54:13 +0100
Message-Id: <20030326215418.30EAAC58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FD90897E35ABD311AE0E0008C7E6404A07192EDE@ca02exch4.sjc.infineon.com> you wrote:
>
> I compiled the 2.4.7 kernel (from TimeSYS) with SCC2 and SCC3 enabled for IO. I have a break-out board where I manually hook into the TXD/RXD/GND pins (Port A, pins 12/13). Now, I'm sending a pattern (FOOOOOO) from the SBC to /dev/tts/1 (SCC2) which is
> connected to a windows box on COM1. All I get on COM1 is garbage. But its not random. I made sure to set all the baud/stop bits/parity manually through IOCTL calls to make sure its right, but still no go. And SCC3 (/dev/tts/2) is completely unresponsive

What exactly do you mean with "garbage, but not copmpletely random"?

Is it the ordinary type of "line noise" as you get when the baud rate
is wrong, or do you get  valid  characters,  but  only  every  second
character  gets  output?  If  you  get  every  second character, this
usually means that your console port is misconfigured.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Always try to do things in chronological order; it's  less  confusing
that way.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
