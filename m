Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 18C91B720C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 04:37:35 +1100 (EST)
Message-ID: <4EC151D5.3040900@freescale.com>
Date: Mon, 14 Nov 2011 11:37:25 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Gang <Gang.Liu@freescale.com>
Subject: Re: [PATCH 4/5, v3] powerpc/8xxx: Update device tree bus probe for
 new RapidIO node binding
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-4-git-send-email-Gang.Liu@freescale.com>
 <4EC15145.3030001@freescale.com>
In-Reply-To: <4EC15145.3030001@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: r58472@freescale.com, Kai Jiang <Kai.Jiang@freescale.com>,
 r61911@freescale.com, linux-kernel@vger.kernel.org, Alexandre.Bounine@idt.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/14/2011 11:35 AM, Scott Wood wrote:
> On 11/12/2011 06:02 AM, Liu Gang wrote:
>> From: Kai Jiang <Kai.Jiang@freescale.com>
>>
>> Update of_platform_bus_probe() RapidIO node to be compitable with
>> new RapidIO dts compatible property.
>>
>> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>  arch/powerpc/platforms/85xx/corenet_ds.c   |    2 +-
>>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
>> index 802ad11..c48b661 100644
>> --- a/arch/powerpc/platforms/85xx/corenet_ds.c
>> +++ b/arch/powerpc/platforms/85xx/corenet_ds.c
>> @@ -112,7 +112,7 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
>>  		.compatible	= "simple-bus"
>>  	},
>>  	{
>> -		.compatible	= "fsl,rapidio-delta",
>> +		.compatible	= "fsl,srio",
> 
> fsl,srio is too vague.  We need to identify the specific hardware (or at
> least a concrete programming interface document), not just the bus  that
> the hardware implements.

Never mind, I see that the binding is more specific about what this
string means.

Next time have the binding come first. :-)

-Scott
