Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id A9441679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 20:13:58 +1000 (EST)
Message-ID: <429AE74F.6090509@anagramm.de>
Date: Mon, 30 May 2005 12:13:35 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
References: <1116607235.29111.20.camel@gleep>	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
	<1117221259.26114.91.camel@cashmere.sps.mot.com>
In-Reply-To: <1117221259.26114.91.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: bd_t Cleaning: Interface Part
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Jon!

I guess there is a little typo:
spped -> speed?

> +unsigned long
> +fw_get_ethspped(void)
> +{
> +#if defined(FW_BDT_HAS_ETHSPEED)
> +	return binfo->bi_ethspeed;
> +#else
> +	return 0;
> +#endif
> +}

and here...

> +unsigned long fw_get_ethspped(void);

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
