Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58043DDF65
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:48:54 +1100 (EST)
Date: Fri, 18 Jan 2008 00:46:32 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] fsl_soc: add support for gianfar for
	fixed-link property
In-Reply-To: <20071206225131.31080.7872.stgit@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0801180046190.16260@blarg.am.freescale.net>
References: <20071206225121.31080.86606.stgit@localhost.localdomain>
	<20071206225131.31080.7872.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Dec 2007, Vitaly Bordug wrote:

>
> fixed-link says: register new "Fixed/emulated PHY", i.e. PHY that
> not connected to the real MDIO bus.
>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> ---
>
>  Documentation/powerpc/booting-without-of.txt |    4 +
>  arch/powerpc/sysdev/fsl_soc.c                |   79 ++++++++++++++++++++------
>  2 files changed, 66 insertions(+), 17 deletions(-)
>

applied.

- k
