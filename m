To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC823E SMC/I2C/SPI micropatch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Jan 2004 10:25:49 +0100."
             <4014DD1D.8070704@devcom.cz>
Date: Mon, 26 Jan 2004 10:33:40 +0100
Message-Id: <20040126093345.5EC57C108D@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <4014DD1D.8070704@devcom.cz> you wrote:
> I think I have selected the __correct__ one.
> Situated in ./arch/ppc/8xx_io/micropatch_850.c file.

No!!! The micropatch_850.c is ONLY for MPC850, and NOT for MPC823(E).

> - it is determined for 850 and 823E processors (I hope).

Wrong.

> And for now, I have SCC2,SCC3 ethernets
> and SMC1,SMC2 UARTs working altogether.

But you might get "strange" effects for example when trying to use SPI.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bus error -- please leave by the rear door.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
