Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F9CFDDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 13:31:08 +1000 (EST)
Message-ID: <48588170.3010303@pobox.com>
Date: Tue, 17 Jun 2008 23:30:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibm_emac: Remove the ibm_emac driver
References: <20080617193523.028d4cc2@zod.rchland.ibm.com>
In-Reply-To: <20080617193523.028d4cc2@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> The arch/ppc sub-tree has been removed in the powerpc git tree.  The old
> ibm_emac driver is no longer used by anything as a result of this.  This
> removes it, leaving the ibm_newemac driver as the proper driver to use for
> PowerPC boards with the EMAC hardware.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  MAINTAINERS                           |    8 -
>  drivers/net/Kconfig                   |    1 -
>  drivers/net/ibm_emac/Kconfig          |   70 -
>  drivers/net/ibm_emac/Makefile         |   11 -
>  drivers/net/ibm_emac/ibm_emac.h       |  329 -----
>  drivers/net/ibm_emac/ibm_emac_core.c  | 2263 ---------------------------------
>  drivers/net/ibm_emac/ibm_emac_core.h  |  222 ----
>  drivers/net/ibm_emac/ibm_emac_debug.c |  211 ---
>  drivers/net/ibm_emac/ibm_emac_debug.h |   62 -
>  drivers/net/ibm_emac/ibm_emac_mal.c   |  570 ---------
>  drivers/net/ibm_emac/ibm_emac_mal.h   |  267 ----
>  drivers/net/ibm_emac/ibm_emac_phy.c   |  398 ------
>  drivers/net/ibm_emac/ibm_emac_phy.h   |   80 --
>  drivers/net/ibm_emac/ibm_emac_rgmii.c |  200 ---
>  drivers/net/ibm_emac/ibm_emac_rgmii.h |   64 -
>  drivers/net/ibm_emac/ibm_emac_tah.c   |  110 --
>  drivers/net/ibm_emac/ibm_emac_tah.h   |   87 --
>  drivers/net/ibm_emac/ibm_emac_zmii.c  |  253 ----
>  drivers/net/ibm_emac/ibm_emac_zmii.h  |   82 --
>  19 files changed, 0 insertions(+), 5288 deletions(-)
>  delete mode 100644 drivers/net/ibm_emac/Kconfig
>  delete mode 100644 drivers/net/ibm_emac/Makefile
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_core.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_core.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_debug.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_debug.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_mal.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_mal.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_phy.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_phy.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_rgmii.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_rgmii.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_tah.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_tah.h
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_zmii.c
>  delete mode 100644 drivers/net/ibm_emac/ibm_emac_zmii.h

applied
