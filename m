Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8EF2DDFD3
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 05:41:28 +1000 (EST)
Message-ID: <48CC1763.2050108@garzik.org>
Date: Sat, 13 Sep 2008 15:41:23 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Victor Gallardo <vgallardo@amcc.com>
Subject: Re: [PATCH] ibm_newemac: Add support for GPCS, SGMII and M88E1112 PHY
References: <1220658926-14014-1-git-send-email-vgallardo@amcc.com>
In-Reply-To: <1220658926-14014-1-git-send-email-vgallardo@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Victor Gallardo wrote:
> This patch adds GPCS, SGMII and M88E1112 PHY support
> for the AMCC PPC460GT/EX processors.
> 
> Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
> ---
>  drivers/net/ibm_newemac/core.c |   40 +++++++++++++++----
>  drivers/net/ibm_newemac/core.h |    3 +
>  drivers/net/ibm_newemac/phy.c  |   84 ++++++++++++++++++++++++++++++++++++++++
>  drivers/net/ibm_newemac/phy.h  |    2 +
>  4 files changed, 120 insertions(+), 9 deletions(-)

ACK, please coordinate with the driver maintainer to get this merged
