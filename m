Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCB2ADDFC9
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 05:41:03 +1000 (EST)
Message-ID: <48CC1747.40408@garzik.org>
Date: Sat, 13 Sep 2008 15:40:55 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] ibm_newemac: Allow the "no flow control" EMAC feature
	to work
References: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
	<62e3d970a3bcb8158308bb645f99c75a41d177ff.1220877899.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <62e3d970a3bcb8158308bb645f99c75a41d177ff.1220877899.git.jwboyer@linux.vnet.ibm.com>
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

Josh Boyer wrote:
> Some PowerPC 40x chips have errata that force us not to use the integrated
> flow control.  We have the feature defined, but it currently can't be used
> because it is never added to EMAC_FTRS_POSSIBLE.
> 
> This adds a Kconfig option for affected platforms to select and puts the
> feature in the EMAC_FTRS_POSSIBLE list.  This is set for PowerPC 405EZ
> platforms as well.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  drivers/net/ibm_newemac/Kconfig |    4 ++++
>  drivers/net/ibm_newemac/core.c  |    2 ++
>  drivers/net/ibm_newemac/core.h  |    3 +++
>  3 files changed, 9 insertions(+), 0 deletions(-)

ACK patches 1-3
