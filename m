To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: "'LinuxPPC '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA Modem/Serial Cards and MPC8xx? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Aug 2003 13:12:09 +0200."
             <3F4C9209.8050301@imc-berlin.de>
Date: Wed, 27 Aug 2003 13:50:47 +0200
Message-Id: <20030827115052.5D4BEC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

in message <3F4C9209.8050301@imc-berlin.de> you wrote:
>
> Now I do get
...
> Serial driver version 5.05c (2001-07-08) with SHARE_IRQ enabled
> ttyS00 at 0xc3071000 (irq = 6) is a ST16654
> ttyS01 at 0xc3071080 (irq = 8) is a ST16654

ttyS00 and ttyS01 are already in use?

> And PCMCIA CS tells me
...
> cardmgr[80]: + Using /lib/modules/2.4.20/pcmcia/serial_cs.o
> ttyS02 at port 0x03f8 (irq = 9) is a 16550A
...
> So why is it ttyS02. Why is it ./serial start ttyS2?

Because ttyS00 and ttyS01 are already in use.

> It's also ttyS2 if I don't enable SCC1 as UART!

ttyS2 or ttyS02?

> I read this. But where does the MAJOR number 240 come from???

See Documentation/devices.txt: LOCAL/EXPERIMENTAL USE

Based on previous experience I saw little chance to get the  resource
conflict solved by the Powers That Be.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We are drowning in information but starved for knowledge.
                                         -- John Naisbitt, Megatrends

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
