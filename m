Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0457DDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:52:24 +1000 (EST)
Message-Id: <84E88152-BE40-44C8-AFA6-0D833983216D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48051FBA.1000801@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and spi
	inits.
Date: Tue, 15 Apr 2008 16:52:12 -0500
References: <20080415185234.GA10579@loki.buserror.net>
	<20080415213221.GA2646@zarina> <48051FBA.1000801@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 4:35 PM, Scott Wood wrote:
> Anton Vorontsov wrote:
>>> +u32 fsl_get_sys_freq(void)
>>> +{
>>> +	struct device_node *soc;
>>> +	const u32 *prop;
>>> +	int size;
>>> +
>>> +	if (sysfreq != -1)
>>> +		return sysfreq;
>>> +
>>> +	soc = of_find_node_by_type(NULL, "soc");
>>> +	if (!soc)
>>> +		return -1;
>> Um.. can we finally decide on compatible for the soc nodes,
>> and add there compatible matching from the start?
>
> This is just a code reorganization; any change in what we match on  
> should be a separate patch.

I agree and Scott has posted a version of this long ago.

- k
