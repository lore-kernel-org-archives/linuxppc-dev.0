Return-Path: <clg@kaod.org>
Received: from 3.mo2.mail-out.ovh.net (3.mo2.mail-out.ovh.net [46.105.58.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsJCt5vJFzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:41:46 +1000 (AEST)
Received: from player692.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id C4DC694046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 08:05:20 +0200 (CEST)
Subject: Re: [PATCH V2 2/2] hwmon: (ibmpowernv) Add current(A) sensor
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux@roeck-us.net,
 stewart@linux.vnet.ibm.com
References: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1497935293-31618-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, linux-hwmon@vger.kernel.org
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f2e849bf-01a0-9af6-cb14-0c454a902d23@kaod.org>
Date: Tue, 20 Jun 2017 08:05:01 +0200
MIME-Version: 1.0
In-Reply-To: <1497935293-31618-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2017 07:08 AM, Shilpasri G Bhat wrote:
> This patch exports current(A) sensors in inband sensors copied to
> main memory by OCC.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
> Changes from V1:
> - Rebased on top of Cedric's patch to remove legay-compatible type for
>   the current(A) sensor.
> 
>  drivers/hwmon/ibmpowernv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 6d8909c..9b11b13 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -50,6 +50,7 @@ enum sensors {
>  	TEMP,
>  	POWER_SUPPLY,
>  	POWER_INPUT,
> +	CURRENT,
>  	MAX_SENSOR_TYPE,
>  };
>  
> @@ -75,7 +76,8 @@ enum sensors {
>  	{ "fan"   },
>  	{ "temp"  },
>  	{ "in"    },
> -	{ "power" }
> +	{ "power" },
> +	{ "curr"  },
>  };
>  
>  struct sensor_data {
> 
