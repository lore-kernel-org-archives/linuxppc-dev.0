Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B165BDEBA3
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:21:06 +1000 (EST)
Date: Thu, 10 May 2007 00:16:37 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 1/2] Suppress warning when CONFIG_PCI is not defined
In-Reply-To: <46428E31.3090007@freescale.com>
Message-ID: <Pine.LNX.4.64.0705100016240.27791@localhost.localdomain>
References: <46428E31.3090007@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007, Li Yang wrote:

> Suppress warning when CONFIG_PCI is not defined.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/83xx/mpc8313_rdb.c |    2 ++
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    2 ++
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    2 ++
> 3 files changed, 6 insertions(+), 0 deletions(-)
>

applied.

- k
