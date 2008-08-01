Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f28.google.com (mail-gx0-f28.google.com
	[209.85.217.28]) by ozlabs.org (Postfix) with ESMTP id 0C930DECDB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:30:05 +1000 (EST)
Received: by gxk9 with SMTP id 9so1356731gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Aug 2008 09:30:03 -0700 (PDT)
Message-ID: <fa686aa40808010930s286381c7ub354b9b98a40c07d@mail.gmail.com>
Date: Fri, 1 Aug 2008 10:30:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Remove use of CONFIG_PPC_MERGE
In-Reply-To: <Pine.LNX.4.64.0808011050370.2074@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0808011050370.2074@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 1, 2008 at 9:50 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
> remove the dead code associated with !CONFIG_PPC_MERGE out of arch/powerpc
> and include/asm-powerpc.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

You need to remove references to it from drivers also

drivers/ata/pata_sil680.c
233:#ifdef CONFIG_PPC_MERGE

drivers/block/floppy.c
4168:#if defined(CONFIG_PPC_MERGE)

drivers/char/ipmi/ipmi_si_intf.c
2703:#ifdef CONFIG_PPC_MERGE

drivers/i2c/busses/i2c-pca-isa.c
116:#ifdef CONFIG_PPC_MERGE

drivers/input/serio/i8042-io.h
70:#if defined(CONFIG_PPC_MERGE)

drivers/usb/host/ehci-hcd.c
1017:#if defined(CONFIG_440EPX) && !defined(CONFIG_PPC_MERGE)

drivers/usb/host/ehci.h
748:#if defined(CONFIG_PPC) && !defined(CONFIG_PPC_MERGE)

drivers/usb/host/ohci.h
536:#if defined(CONFIG_PPC) && !defined(CONFIG_PPC_MERGE)

drivers/net/fs_enet/mac-fec.c
316:#ifndef CONFIG_PPC_MERGE
418:#ifndef CONFIG_PPC_MERGE

drivers/net/fs_enet/mac-scc.c
376:#ifndef CONFIG_PPC_MERGE

drivers/pnp/isapnp/core.c
1015:#ifdef CONFIG_PPC_MERGE

drivers/pnp/pnpbios/core.c
522:#if defined(CONFIG_PPC_MERGE)
580:#if defined(CONFIG_PPC_MERGE)

drivers/serial/mpc52xx_uart.c
76:#if defined(CONFIG_PPC_MERGE)
110:#if defined(CONFIG_PPC_MERGE)
258:#if defined(CONFIG_PPC_MERGE)
889:#if !defined(CONFIG_PPC_MERGE)
949:#if !defined(CONFIG_PPC_MERGE)
1056:#endif /* defined(CONFIG_PPC_MERGE) */
1075:#if defined(CONFIG_PPC_MERGE)
1104:#if !defined(CONFIG_PPC_MERGE)
1208:#endif /* !defined(CONFIG_PPC_MERGE) */
1211:#if defined(CONFIG_PPC_MERGE)
1405:#endif /* defined(CONFIG_PPC_MERGE) */
1426:#if defined(CONFIG_PPC_MERGE)
1453:#if defined(CONFIG_PPC_MERGE)

drivers/spi/mpc52xx_psc_spi.c
19:#if defined(CONFIG_PPC_MERGE)
474:#if !defined(CONFIG_PPC_MERGE)
519:#else	/* defined(CONFIG_PPC_MERGE) */
589:#endif	/* defined(CONFIG_PPC_MERGE) */


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
