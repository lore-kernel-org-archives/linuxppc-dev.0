Message-ID: <3C678EDC.20503@pacbell.net>
Date: Mon, 11 Feb 2002 09:29:00 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: "David =?ISO-8859-15?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Several patches against linuxppc_devel-2.4.18-pre9
References: <3C67D5EE.70008@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Müller (ELSOFT AG) wrote:
> Hello
>
> The attached patch fixes the following issues:
>
>    - drivers/net/ibm_ocp_enet.c
>       wrong prototypes + initialisation in debug code
>
>    - drivers/net/ibm_ocp_enet.h
>       missing prototypes for [get|set]_maltxdeir()
>       missing prototypes for [get|set]_maltxctp1r()
>
>    - drivers/net/ibm_ocp_phy.c
>       workaround for MII-PHY communication bug reported by Andrew May
>
>    - arch/ppc/mm/fault.c
>       missing type cast
>
>    - arch/ppc/mm/cachemap.c
>       missing prototype for map_page() (added mmu_decl.h)
>       2 missing type casts
>
> Dave
>


Dunka David..

The ethernet changes look fine.  there was on other change regarding
resetting the EMAC. The ethernet part can go in as is our we can wait
until tomorrow when I send in that change + multi emac irq fix.

-armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
