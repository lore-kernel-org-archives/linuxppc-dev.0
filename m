Message-ID: <20020820120811.72432.qmail@mail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
From: "Pete Smithers" <petesmithers@mail.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 20 Aug 2002 07:08:11 -0500
Subject: Re: Compile fix for 4xx (linuxppc_2_4_devel)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> This fixes compile on 4xx machines, which was broken by the recent
> heartbeat changes.  Please apply.
>
> [...]
> --- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	2002-08-05 10:37:17.000000000 +1000
> +++ linux-grinch/arch/ppc/kernel/ppc4xx_setup.c	2002-08-19 15:05:01.000000000 +1000
> @@ -415,7 +415,7 @@
>  #ifdef CONFIG_PPC405_WDT
>  	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;

of course this one has to be changes as well

Pete
--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
