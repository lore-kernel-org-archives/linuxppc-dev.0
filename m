To: Andrey Volkov <avolkov@varma-el.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: port from 2.4.21 to 2.6.8 for mpc5200 - part 1 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 22 Aug 2004 22:31:08 +0400."
             <679770249.20040822223108@varma-el.com>
Date: Mon, 23 Aug 2004 01:57:30 +0200
Message-Id: <20040822235735.664ADC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <679770249.20040822223108@varma-el.com> you wrote:
>
> Below path of kernel-2.6.8.1 for Motorola MPC5200.
> This patch was based on MontaVista 2.4.21 kernel, and
> included:
>
> * Motorola BestComm API support
> * little correction in Kconfig/Makefile to support it

This patch is based on a very old version of the BestComm code.  This
version  of  the code contains several well known bugs, and it is NOT
available under a GPL compatible license.

Please make sure to use a current and GPLed version of  the  BC  code
instead.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
