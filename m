To: Anish <anish@cdotb.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Query 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Oct 2002 16:20:10 +0500."
             <Pine.OSF.4.21.0210111618230.16143-100000@ws9.cdotb.ernet.in>
Date: Fri, 11 Oct 2002 13:43:44 +0200
Message-Id: <20021011114349.75271FAA2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.OSF.4.21.0210111618230.16143-100000@ws9.cdotb.ernet.in> you wrote:
>
> Can anybody direct me for and SMC UART device driver for Linux.

What's wrong with arch/ppc/8xx_io/uart.c and  arch/ppc/8260_io/uart.c ?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I had the rare misfortune of being one of the first people to try and
implement a PL/1 compiler.                             -- T. Cheatham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
