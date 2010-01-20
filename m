Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56A27B7CB8
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 22:21:45 +1100 (EST)
Message-ID: <4B56E73B.8040903@embedded-sol.com>
Date: Wed, 20 Jan 2010 13:21:31 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/4xx: Add support for type 1 pci transactions
	on 4xx boards
References: <4CD35CD1F8085945B597F80EEC89421303B8AD11@exc01.bk.prodrive.nl>	<1263338326.724.216.camel@pasglop>
	<1263444961.724.343.camel@pasglop>	<4B5637A6.5070600@embedded-sol.com>
	<1263941873.724.524.camel@pasglop>
In-Reply-To: <1263941873.724.524.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stef van Os <stef.van.os@Prodrive.nl>, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Stef

Benjamin Herrenschmidt wrote:
> On Wed, 2010-01-20 at 00:52 +0200, Felix Radensky wrote:
>   
>> 405XX - no
>> 440EP - no
>> 440GR - no
>> 440EPx/440GRx - no
>>
>> 440GP - yes
>> 440GX - yes
>> 440SP - yes
>> 440SPe - yes
>> 460XX - yes
>>
>> The distinction between these groups is pretty clear in the device trees.
>> The members of the first group all have "ibm,plb-pci" property, and all
>> members of second group have "ibm,plb-pcix" property.
>>
>> So only ppc4xx_probe_pcix_bridge() routine should be fixed.
>>     
>
> Ah cool, I hadn't noticed that it matched the cell type.
>
>   

Can you please send an updated patch.

Thanks a lot.

Felix.
