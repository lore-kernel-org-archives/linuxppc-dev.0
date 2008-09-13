Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9D0CDDF36
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 05:12:46 +1000 (EST)
Message-ID: <48CC10A3.6020608@garzik.org>
Date: Sat, 13 Sep 2008 15:12:35 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH 1/2] ehea: fix phyp debugging typo
References: <1221140080-9853-1-git-send-email-sebastien.dugue@bull.net>
	<1221140080-9853-2-git-send-email-sebastien.dugue@bull.net>
In-Reply-To: <1221140080-9853-2-git-send-email-sebastien.dugue@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, tinytim@us.ibm.com, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sebastien Dugue wrote:
>   Fix typo in ehea_h_query_ehea() which prevents building when DEBUG is on.
> 
> Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
> ---
>  drivers/net/ehea/ehea_phyp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ehea/ehea_phyp.c b/drivers/net/ehea/ehea_phyp.c
> index 156eb63..2a33a61 100644
> --- a/drivers/net/ehea/ehea_phyp.c
> +++ b/drivers/net/ehea/ehea_phyp.c
> @@ -535,7 +535,7 @@ u64 ehea_h_query_ehea(const u64 adapter_handle, void *cb_addr)
>  				       cb_logaddr,		/* R5 */
>  				       0, 0, 0, 0, 0);		/* R6-R10 */
>  #ifdef DEBUG
> -	ehea_dmp(cb_addr, sizeof(struct hcp_query_ehea), "hcp_query_ehea");
> +	ehea_dump(cb_addr, sizeof(struct hcp_query_ehea), "hcp_query_ehea");
>  #endif
>  	return hret;

applied
