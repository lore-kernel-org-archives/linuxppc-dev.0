To: "Donald MacArthur" <dmacarth@ufl.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 UART for MPC850 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Mar 2003 08:52:41 EST."
             <NDBBIHDFKLJKGJJGMFJOIEANCHAA.dmacarth@ufl.edu>
Date: Mon, 03 Mar 2003 15:11:09 +0100
Message-Id: <20030303141114.B9412C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NDBBIHDFKLJKGJJGMFJOIEANCHAA.dmacarth@ufl.edu> you wrote:
>
> I am currently working with an embedded planet LICCE MPC850 Credit card
> board with the associated MPC860 Timesys Linux Kernel.  I would like to use
> as many SCC and SMC channels for UARTs as possible.  I have successfully
> enabled SMC1, SMC2, and SCC2 for UART but SCC3 does not work.  Normally for
> the UART channels the TX lines go high when the kernel boots but the SCC3 Tx
> channel does not.  Does anyone know of modifications required for the kernel
> to get SCC3 to work as a UART or were possible conflicts might arise?

See the uart.c driver in the kernel source tree on our CVS server for
support of serial ports on all SMC / SCC ports.

Sorry, this is one of our patches that never  was  accepted  for  the
official source trees (also including hardware flow control).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You have the capacity to learn from  mistakes.  You'll  learn  a  lot
today.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
