Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6A1FDE27F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 03:04:32 +1100 (EST)
Message-Id: <089EA00D-8EAB-417D-9A4B-FA500D23FF8D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080124204621.2c09359e.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 4/9] enable FSL SATA driver config for Freescale SoCs
Date: Fri, 25 Jan 2008 10:04:08 -0600
References: <20080124204621.2c09359e.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 24, 2008, at 8:46 PM, Kim Phillips wrote:

> The mpc8315 shares the same SATA controller as the mpc837x,
> and likelihood is that future SoCs from Freescale will also.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> Kumar, let me know if you want me to post this to the ata list (I'm
> assuming it's not necessary).

It is necessary so they are aware.  CC jgarizk, but we'll take it via  
powerpc.

- k
