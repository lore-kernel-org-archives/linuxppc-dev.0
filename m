Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 421B6DE12E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:11:03 +1000 (EST)
Message-Id: <2DD737A1-A0DA-4D74-8F2B-6885FB434021@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311172328.GA7727@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/8] [POWERPC] fsl_elbc_nand: factor out localbus defines
Date: Mon, 14 Apr 2008 10:10:50 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172328.GA7727@localhost.localdomain>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:23 PM, Anton Vorontsov wrote:
> This is needed to support other localbus peripherals, such as
> NAND on FSL UPM.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Would be great if someone from the MTD community will ack this patch
> to go through powerpc trees.
>
> Thanks,
>
> drivers/mtd/nand/fsl_elbc_nand.c |  219 + 
> +-----------------------------------
> include/asm-powerpc/fsl_lbc.h    |  223 +++++++++++++++++++++++++++++ 
> +++++++++
> 2 files changed, 235 insertions(+), 207 deletions(-)
> create mode 100644 include/asm-powerpc/fsl_lbc.h

applied.

- k
