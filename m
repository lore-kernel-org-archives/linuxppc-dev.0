To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory mapped serial driver for 16554 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Apr 2004 08:46:24 EDT."
             <294FD9D3403A0340BDAC38E48DCEFFDCA7C1@RES-EXCH>
Date: Sun, 11 Apr 2004 18:57:33 +0200
Message-Id: <20040411165738.2AD82C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <294FD9D3403A0340BDAC38E48DCEFFDCA7C1@RES-EXCH> you wrote:
>
> I have a board with mpc8xx, running linux 2.4.18. It has 16554, quad uart.

In our linux-2.4 kernel tree we support the Exar ST16C554 quad UART
for a board; see "drivers/char/serial.c" and look for
CONFIG_SERIAL_TTTECH.

> I am using serial driver from denx, and I used it successfully for other
> board which had 16550 uart, and had interrupts hooked to IRQ4 and IRQ5.
> The new board has 4 interrupts hooked on PC8,PC9,PC10 and PC11. My
> question-
>
> How do I hook the these to the serial driver? I followed the same model as
> DAB4K board to run earlier driver.

Basicly you can  just  do  the  same  like  we  did  for  the  TTTECH
configuration;  the  only  significant  difference  is that we used a
shared interrupt; therefore  you  should  NOT  #define  the  variable
CONFIG_SERIAL_SHARE_IRQ

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Voodoo Programming: Things programmers do that  they  know  shouldn't
work  but they try anyway, and which sometimes actually work, such as
recompiling everything.                             - Karl Lehenbauer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
