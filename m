Message-ID: <3C58410B.802BC1F4@mvista.com>
Date: Wed, 30 Jan 2002 10:52:59 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: David =?iso-8859-1?Q?M=FCller?= (ELSOFT AG) <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 3 patches against linuxppc_dev-2.4.18-pre7
References: <3C57F9AC.9040008@elsoft.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"David Müller (ELSOFT AG)" wrote:
>
> Hello
>
> The attached patch fixes the following issues:
>
>     - arch/ppc/kernel/ppc4xx_pic.c
>        fixed constant in ppc405_pic_get_irq()
>        (should be NR_AIC_IRQS as in ppc403_pic_get_irq())

David,

include/asm-ppc/irq.h
NR_IRQS = (NR_AIC_IRQS + NR_BOARD_IRQS) and was defined to allow
cascading UIC's.
NR_BOARD_IRQS is defined in some of the board files and its default is
in include/asm-ppc/ibm4xx.h

So i don't see the need to patch that file but the others look fine.


-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
