Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59535DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 May 2007 10:45:43 +1000 (EST)
Message-ID: <464CF731.6030508@garzik.org>
Date: Thu, 17 May 2007 20:45:37 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: ebs@ebshome.net
Subject: Re: [PATCH 1/3] ibm_emac: fix section mismatch warnings
References: <20070516185737.GA14704@gate.ebshome.net>
In-Reply-To: <20070516185737.GA14704@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> Fix "Section mismatch" warnings
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> 
> ---
>  drivers/net/ibm_emac/ibm_emac_mal.c   |    3 +--
>  drivers/net/ibm_emac/ibm_emac_mal.h   |    3 +--
>  drivers/net/ibm_emac/ibm_emac_rgmii.c |    2 +-
>  drivers/net/ibm_emac/ibm_emac_rgmii.h |    2 +-
>  drivers/net/ibm_emac/ibm_emac_tah.c   |    2 +-
>  drivers/net/ibm_emac/ibm_emac_tah.h   |    2 +-
>  drivers/net/ibm_emac/ibm_emac_zmii.c  |    2 +-
>  drivers/net/ibm_emac/ibm_emac_zmii.h  |    2 +-
>  8 files changed, 8 insertions(+), 10 deletions(-)

applied 1-3

Please fix your incorrect Mail-Followup-To headers.  They cause mailers 
to NOT direct replies to you, and CC lists, which is contra to normal 
LKML behavior.
