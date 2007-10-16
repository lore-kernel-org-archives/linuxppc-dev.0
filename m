Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB224DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:17:48 +1000 (EST)
In-Reply-To: <20071015163324.8520.3528.stgit@trillian.cg.shawcable.net>
References: <20071015163324.8520.3528.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96D13B28-206A-4BC6-8769-D86B2D49E0D7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mpc8349emitx(gp): add UHCI support and other misc
	defconfig changes
Date: Tue, 16 Oct 2007 00:18:00 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2007, at 11:33 AM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> USB support for the 8349itx got added a while back; but the defconfig
> never got updated.  This patch updates defconfig and adds the  
> appropriate
> USB config options.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Scott Wood <scottwood@freescale.com>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Timur Tabi <timur@freescale.com>
> ---
>
>  arch/powerpc/configs/mpc834x_itx_defconfig   |   87 ++++++++----
>  arch/powerpc/configs/mpc834x_itxgp_defconfig |  190 +++++++++++++++ 
> +++++++----
>  2 files changed, 224 insertions(+), 53 deletions(-)

Can you limit this to the USB support?  The other changes like  
enabling SLUB, and PRINTK_TIME, should really be clearly documented  
and discussed some.

- k
