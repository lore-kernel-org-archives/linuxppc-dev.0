Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB73EDE15E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 04:41:21 +1100 (EST)
Date: Wed, 19 Mar 2008 12:41:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mike Hench <mhench@engagenet.com>
Subject: Re: [PATCH] corrected MPC8313 NAND fixes
Message-ID: <20080319174104.GG7962@ld0162-tx32.am.freescale.net>
References: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D11@mailsrv.engagenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D11@mailsrv.engagenet.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 12:40:15PM -0500, Mike Hench wrote:
> Fix a race condition in fsl_elbc_run_command
> Fix incorrect usage of clearbits32 that bashed option register
> Remove work around for bashed register
> 
> Signed-off-by: Mike Hench <mhench@elutions.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
