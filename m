Message-ID: <3CD199C0.6070700@pacbell.net>
Date: Thu, 02 May 2002 12:55:44 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches against linuxppc_devel-2.4.19-pre7
References: <3CD1382D.8060109@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Müller (ELSOFT AG) wrote:
> Hello
>
> The attached patch fixes the following issues:
>
>    - arch/ppc/kernel/ocp_uart.c
>       fixes problem with "ghost" uart device
>
>       I'm not sure if this is the correct fix or if
>       the semantic of ocp_register() should be changed?
>
>    - drivers/char/ibm_ocp_gpio.c
>       fixes typo ([pv]start instead of [pv]addr)
>
>    - arch/ppc/platforms/Makefile
>       include ibm405gp.o into export-objs list
>
>    - arch/ppc/platforms/ibm405gp.c
>       export base address symbols for use with modularized
>       OCP device drivers
>
>       Shouldn't IIC_ADDR also be "const struct"?
>
>    - include/asm-ppc/floppy.h
>       fixes swapped arguments of {fd_}outb
>
>
> Dave
>

Dave

Thanks

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
