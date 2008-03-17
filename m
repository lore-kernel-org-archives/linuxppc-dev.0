Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D69E4DDEDC
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 23:08:46 +1100 (EST)
Message-ID: <47DE5F4A.9080303@garzik.org>
Date: Mon, 17 Mar 2008 08:08:42 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: NEWEMAC: Add compatible "ibm,tah" to tah matching
	table
References: <1205423983-21142-1-git-send-email-sr@denx.de>
In-Reply-To: <1205423983-21142-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> Add "ibm,tah" to the compatible matching table of the ibm_newemac
> tah driver. The type "tah" is still preserved for compatibility reasons.
> New dts files should use the compatible property though.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/net/ibm_newemac/tah.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

applied
