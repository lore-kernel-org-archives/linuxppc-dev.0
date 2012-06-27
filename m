Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76C03100B63
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 17:09:32 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 03:09:29 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9D9E138C801B
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 03:09:26 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5R79QnL26804276
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 03:09:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5R79Pgp008571
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 04:09:26 -0300
Date: Wed, 27 Jun 2012 15:09:22 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: fix whitespace in eeh
Message-ID: <20120627070922.GA13008@shangw>
References: <3149.1340770321@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3149.1340770321@neuling.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Signed-off-by: Michael Neuling <mikey@neuling.org>
>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>index 8752f79..c33360ec 100644
>--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>@@ -81,7 +81,7 @@ static int pseries_eeh_init(void)
> 	ibm_get_config_addr_info2	= rtas_token("ibm,get-config-addr-info2");
> 	ibm_get_config_addr_info	= rtas_token("ibm,get-config-addr-info");
> 	ibm_configure_pe		= rtas_token("ibm,configure-pe");
>-	ibm_configure_bridge		= rtas_token ("ibm,configure-bridge");
>+	ibm_configure_bridge		= rtas_token("ibm,configure-bridge");
>
> 	/* necessary sanity check */
> 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE) {
>@@ -89,7 +89,7 @@ static int pseries_eeh_init(void)
> 			__func__);
> 		return -EINVAL;
> 	} else if (ibm_set_slot_reset == RTAS_UNKNOWN_SERVICE) {
>-		pr_warning("%s: RTAS service <ibm, set-slot-reset> invalid\n",
>+		pr_warning("%s: RTAS service <ibm,set-slot-reset> invalid\n",
> 			__func__);
> 		return -EINVAL;
> 	} else if (ibm_read_slot_reset_state2 == RTAS_UNKNOWN_SERVICE &&
