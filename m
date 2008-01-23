Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id B4A95DDF42
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 07:15:27 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so167179uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 12:15:25 -0800 (PST)
Message-ID: <4797A127.8070401@genesi-usa.com>
Date: Wed, 23 Jan 2008 20:18:47 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 3/3] Add device tree compatible aliases to i2c drivers
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020916.31675.98481.stgit@terra.home>
In-Reply-To: <20080123020916.31675.98481.stgit@terra.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Jon Smirl wrote:
> --- a/drivers/i2c/chips/tps65010.c
> +++ b/drivers/i2c/chips/tps65010.c
> @@ -571,6 +571,10 @@ static const struct i2c_device_id tps65010_id[] = {
>  	{ "tps65011", TPS65011 },
>  	{ "tps65012", TPS65012 },
>  	{ "tps65013", TPS65013 },
> +	OF_ID("ti,tps65010", TPS65010)
> +	OF_ID("ti,tps65011", TPS65011)
> +	OF_ID("ti,tps65012", TPS65012)
> +	OF_ID("ri,tps65013", TPS65013)
>  	{ },

ti, ti, ti, ri?

> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -129,6 +129,12 @@ static const struct i2c_device_id ds1307_id[] = {
>  	{ "ds1339", ds_1339 },
>  	{ "ds1340", ds_1340 },
>  	{ "m41t00", m41t00 },
> +	OF_ID("dallas,ds1307", ds_1307)
> +	OF_ID("dallas,ds1337", ds_1337)
> +	OF_ID("dallas,ds1338", ds_1338)
> +	OF_ID("dallas,ds1339", ds_1339)
> +	OF_ID("dallas,ds1340", ds_1340)
> +	OF_ID("stm,m41t00", m41t00)
>  	{},
>  };

The convention is to use the stock ticker, capitalized, if a company
has one, I guess dallas is MXIM these days, but dallas is a good
substitute based on the fact that most people still remember Dallas
clock chips and so on from the Ancient Days. STMicroelectronics is STM.
I couldn't care less about case sensitivity, but the stock ticker
thing was always a good idea.. it gives a sort of grounding in reality
for the manufacturer names.

Are we still following this convention or are the names of devices
simply arbitrarily defined by Linux kernel developers now?

--
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
