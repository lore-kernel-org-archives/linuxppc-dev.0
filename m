Message-ID: <01ff01bff7d8$4b122460$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: "Dan Malek" <dan@netx4.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <01ba01bff79b$9ee78db0$1952df8d@SOYANG> <39804084.5EA8BA01@embeddededge.com>
Subject: Re: Req. help about SCC2 and SCC3 as ethernet.
Date: Thu, 27 Jul 2000 23:38:13 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Dan Malek" <dan@netx4.com>
To: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, July 27, 2000 11:00 PM
Subject: Re: Req. help about SCC2 and SCC3 as ethernet.


> How do you know that is where it stops?

We are currently using remote GDB with abatron BDI2000. In console_serial_write function, this function can't return any character....

> With SCC3, you are now
> trying to configure Port B, which is also used for the SMC1 configuration.
> Perhaps the console and kernel are working fine, and you just messed up
> the I/O pins for SMC1.

All pin assignments are correct, and during setting port B, we checked the pbpar,pbdir,pbodr also. nothing changed.


> You will also need to make source code changes to enet.c, as it doesn't
> have a standard set of instructions for configuring port B as Ethernet
> control/data pins.

We've changed all port configurations.
>
>
> -- Dan
>

Do you have any code which enables SCC3 for ethernet on 850SAR?


Thank you


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
