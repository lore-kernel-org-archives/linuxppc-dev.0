Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 395BA68882
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 16:49:42 +1100 (EST)
From: Matthew McClintock <msm@freescale.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <438B379B.6090904@ru.mvista.com>
References: <438B379B.6090904@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 23:49:23 -0600
Message-Id: <1133848163.7932.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Adds MPC885ADS, MPC866ADS and
	MPC8272ADS-specific  platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-28 at 10:00 -0700, Vitaly Bordug wrote:
> +       mpc82xx_fcc1_pdata.dpram_offset =
> mpc82xx_fcc2_pdata.dpram_offset = (u32)cpm2_immr->im_dprambase;
> +       mpc82xx_fcc1_pdata.fcc_regs_c = mpc82xx_fcc2_pdata.fcc_regs_c
> = (u32)cpm2_immr->im_fcc_c; 

I'm not sure if this has already been discussed, but what is stopping us
from including this in the platform definition files along with the
other offsets?

-Matthew
