Message-ID: <3C6FCBFD.80504@pacbell.net>
Date: Sun, 17 Feb 2002 15:27:57 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: "David =?ISO-8859-15?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches against linuxppc_devel-2.4.18-rc1
References: <3C6E5603.5010801@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Müller (ELSOFT AG) wrote:
> Hello
>
> The attached patch fixes the following issues:
>
>    - arch/ppc/kernel/Makefile
>       ppc4xx_pm.o missing in export-objs list
>
>    - arch/ppc/kernel/ppc4xx_pm.c
>       missing include file + missing #ifdef #endif
>
ok.

>    - arch/ppc/kernel/ppc4xx_pic.c
>       fixed constant in ppc405_pic_get_irq()
>       (NR_IRQS is not necessarily the total number of UIC irqs)a

hmmmmm... we should get ride of "NR_BOARD_IRQS" instead?

>
>    - arch/ppc/platforms/ibm_ocp.h
>       wrong header file included + some little name fixes
header file fix all ready in.  I will get the name change next patch in.


>
>
> Regarding the newly introduce support for cascaded UICs:
>
> Isn't the CONFIG_CASCADING_UIC option redundant?
> If (CONFIG_CASCADING_UIC == (NR_UICS > 1)) is true, CONFIG_CASCADING_UIC
> could be replace by (NR_UICS > 1).
>

Good point:)

> Dave

Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
