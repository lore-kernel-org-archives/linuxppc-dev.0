Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1F6FDDE36
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:13:04 +1000 (EST)
Subject: Re: [PATCH] POWERPC: Added RTC support for mpc8313RDB and utilize
	"clock-frequency"
From: Jon Loeliger <jdl@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20070717214824.04db9e88@vitb.ru.mvista.com>
References: <20070717004913.21682.50282.stgit@localhost.localdomain>
	<20070717163645.GB7347@ld0162-tx32.am.freescale.net>
	<20070717214824.04db9e88@vitb.ru.mvista.com>
Content-Type: text/plain
Message-Id: <1184695975.24473.17.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 17 Jul 2007 13:12:55 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-17 at 12:48, Vitaly Bordug wrote:
> 't.
> > 
> Yet many boards still have this stuff (like pretty recent 86xx) - should
> we at least add some comments or clean that up?

Hrm.  Alright.  I'm on deck for a patch here, I see... :-)

But you might notice that the most recent board port
that I added, mpc8544_ds.c, does NOT have it:

        static void __init mpc8544_ds_setup_arch(void)
        {
                if (ppc_md.progress)
                        ppc_md.progress("mpc8544_ds_setup_arch()", 0);
         
                printk("MPC8544 DS board from Freescale Semiconductor\n");
        }

Thanks,
jdl
